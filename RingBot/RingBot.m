classdef RingBot < handle
    % RingBot Class for storing robot information and computing
    % trajectories
    properties (Constant)
        % Density of links (i.e., mass per volume). For a prismatic joint, you should set its weight to the volume corresponding to its maximum length times link_density.
        link_density = 0.5;
        % Mass of rotational joints.
        joint_mass = 0.75; % todo
        ring_radius = 0.1;
    end
    
    properties
        link_vectors;
        prismatic;
        joint_axes;
        link_colors;
        dof;
        figure; % Handle to the plot of the arm
    end
    
    methods
        %% REQUIRED FUNCTIONS FOR TEMPLATE
        function obj = RingBot(link_vectors, joint_axes,prismatic, link_colors)
            %RINGROBOT Construct an instance of this class
            %
            % link_vectors: 1xn cell array of 3x1 vectors where each vector represents the link in the joint's frame
            % joint_axes: nx1 cell array with characters 'x','y',or'z' specifying the axes of each joint
            % prismatic: nx1 vector with values of 0 for a rigid link or 1 for a link that can extend
            % link_colors: nx1 cell array with colors
            
            obj.link_vectors = link_vectors;
            obj.prismatic = prismatic;
            obj.joint_axes = joint_axes;
            obj.link_colors = link_colors;
            obj.dof = numel(joint_axes);
        end
        
        function drawArm(obj, joint_angles, link_extensions)
            link_set = threeD_links_with_ring(obj.link_vectors,joint_angles,obj.joint_axes,link_extensions,obj.prismatic, obj.ring_radius);
            ax = create_axes(317);
            axis([-5 5 -5 5 0 5]); % Set axes limits
            obj.figure = threeD_draw_links(link_set,obj.link_colors,ax);
            
            view(ax,3)
            axis(ax,'vis3d');
        end
        
        function updateArm(obj, joint_angles, link_extensions)
            link_set = threeD_links_with_ring(obj.link_vectors,joint_angles,obj.joint_axes,link_extensions,obj.prismatic, obj.ring_radius);
            threeD_update_links(obj.figure, link_set);
        end
        
        function link_set = getLinksWithRing(obj, joint_angles, link_extensions)
            % Gets called in checkCollision (DO NOT EDIT)
            link_set = threeD_links_with_ring(obj.link_vectors,joint_angles,obj.joint_axes,link_extensions,obj.prismatic, obj.ring_radius);
        end
    
        %% my functions
        %COST FUNCTION
        %z = [0;0;1];

        
        
            
        

   
        
        %% REQUIRED BY STUDENT TO IMPLEMENT
        function [joint_angles, link_extensions, joint_torques, link_torques] = followWire(obj, wire, initial_thetas, initial_link_extensions)
            % Generates a trajectory in theh configuration space to follow the wire
            %
            % INPUTS
            % wire:3 x n matrix where n = number of points in the wire
            % initial_thetas: dof x 1 vector
            % initial_link_extensions: dof x 1 vector
            %
            % OUTPUTS
            % joint_angles: n x m matrix of joint angles along the trajectory, 
            % where n = number joints, m = number points in trajactory.
            % link_extensions: n x m matrix of link extensions for prismatic links
            % This value is ignored for links that are not prismatic
            % joint_torques: n x m matrix of joint torques computed at the corresponding
            % configurations along the trajectory
            % link_torques: n x m matrix of prismatic link torques. (Leave 0 for
            % links that are not prismatic)
             dist = norm(wire(:,2) - wire(:,1));
             if dist < 0.01
                 wire = downsample(wire',10)';
             end
             
             %changing dof stuff
             rr = 3; % number of dof used for position
             j_start = rr + 1; %number of joints used for orientation (J_end - J_start)
             j_end = j_start +2;
             %prismatic link length
             length = [0;0;0;1;0;0;0];
             
             
            joint_angles = zeros(obj.dof,size(wire,2));
            link_extensions = zeros(obj.dof,size(wire,2));
            joint_torques = zeros(obj.dof,size(wire,2));
            link_torques = zeros(obj.dof,size(wire,2));
            F = zeros(obj.dof,size(wire,2));
            ub = [];
            lb = [];
            A = [];
            b = [];
            Aeq = [];
            beq = [];
            nonlcon = [];
            options = [];
            target = wire(:,1);
            %input = [initial_thetas,initial_link_extensions];
            input = [initial_thetas(1:rr),initial_link_extensions(1:rr)];
            
            %h = @(q) cost(q,target,obj.link_vectors,obj.joint_axes);
            %h = @(q) cost2(q,target,obj.link_vectors,obj.joint_axes,initial_link_extensions,obj.prismatic);
            h = @(input) cost3(input,target,obj.link_vectors(1:rr),obj.joint_axes(1:rr),obj.prismatic(1:rr),obj.ring_radius);
            q = fmincon(h,input,A,b,Aeq,beq,lb,ub,nonlcon,options);
            joint_angles(1:rr,1) = q(1:rr,1);
            link_extensions(1:rr,1) = q(1:rr,2);
            
            z = [0;0;1];
            
            for i = 2:size(wire,2)-1
                dist = norm(wire(:,i+1) - wire(:,i));
                if dist < 0.02 
                    options = optimoptions('fmincon','OptimalityTolerance',0.001,'MaxIterations',200);
                
                else
                    target = wire(:,i);
                end
                    
                input = q;
                %h = @(q) cost(q,target,obj.link_vectors,obj.joint_axes);
                %h = @(q) cost2(q,target,obj.link_vectors,obj.joint_axes,initial_link_extensions,obj.prismatic);
                h = @(input) cost3(input,target,obj.link_vectors(1:rr),obj.joint_axes(1:rr),obj.prismatic(1:rr),obj.ring_radius);
                q = fmincon(h,input,A,b,Aeq,beq,lb,ub,nonlcon,options);
                joint_angles(1:rr,i) = q(1:rr,1);
                link_extensions(1:rr,i) = q(1:rr,2);
                
                % Joint torques
                [F(:,i),...
                  ~,...
                  ~,...
                  ~,...
                  ~,...
                  ~] = gravitational_moment(obj.link_vectors,joint_angles(:,i),obj.joint_axes,obj.prismatic,obj.link_density,length);
                %z = [0;0;1]
                if i < size(wire,2)
                    diff = (wire(:,i+1) - wire(:,i));
                    dir = diff/norm(diff);
%                     if isnan(dir(1))
%                         joint_angles(j_start:j_end,i) = [0;0;0];
%                         continue
%                     end
%                     R = [dot(z,dir) -norm(cross(z,dir)) 0; norm(cross(z,dir)) dot(z,dir) 0; 0 0 1];
%                     joint_angles(j_start:j_end,i) = rotm2eul(R,'ZYZ');
                    
                    x = dir(1);
                    y = dir(2);
                    z = dir(3);
                   
                    if abs(z) > 0.8
                        joint_angles(j_start:j_end,i) = [pi/2;0;0];  
                    elseif abs(z)<0.1
                        joint_angles(j_start:j_end,i) = [0;0;0];
                    elseif abs(x) < 0.1
                        if  z > 0
                            joint_angles(j_start:j_end,i) = [pi/2;-pi/4;0];
                        elseif z < 0
                            joint_angles(j_start:j_end,i) = [pi/2;pi/4;0];
                        end
                    elseif abs(y) < 0.1
                        if  z > 0
                            joint_angles(j_start:j_end,i) = [pi/2;0;pi/4];
                        elseif z < 0
                            joint_angles(j_start:j_end,i) = [pi/2;0;-pi/4];
                        end
                    else
                        joint_angles(j_start:j_end,i) = [0;0;0];
                    end
                    
%                     R = [dot(z,dir) -norm(cross(z,dir)) 0; norm(cross(z,dir)) dot(z,dir) 0; 0 0 1];
%                     joint_angles(4:6,i) = rotm2eul(R,'ZYZ');
                end
                 for i = 1:obj.dof
                    if obj.prismatic(i) == 0
                        joint_torques(i,:) = F(i,:);
                    else
                        link_torques(i,:) = F(i,:);
                    end
                 end

                  
%                          
            end
            

            
            
        end
    end
end




















