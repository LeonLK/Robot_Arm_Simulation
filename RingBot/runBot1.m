 link_vectors = {[0;0;0.6],[0;0;3],[0;0;2.48528],[0;0;0.01],[0;0;0.01],[0;0;0.01]}; % TODO
%link_vectors = {[0;0;0.6],[0;0;3],[0;0;2.48528],[0;0.01;0],[0;0.01;0],[0;0.01;0]}; % TODO
joint_axes = {'z','x','x','z','y','x'}; %TODO
%joint_axes = {'z','x','x','x','y','x'};
link_colors = ['k','b','r','k','b','r','g'];%TODO
prismatic = [0;0;0;0;0;0]; %TODO

robot = RingBot(link_vectors,joint_axes,prismatic, link_colors);
load('Wires/wire1.mat', 'wire');

% Initial values for joint angles and link extensions
joint_angles = [0;1/2;-1/2;0;0;0]*pi;% TODO
link_extensions = [0;0;0;0;0;0];%TODO
visualizeTrajectory(robot, wire, joint_angles, link_extensions);
%visualizeTrajectory(robot, wire, joint_angles, link_extensions);





%followire for this
%         function [joint_angles, link_extensions, joint_torques, link_torques] = followWire(obj, wire, initial_thetas, initial_link_extensions)
%             % Generates a trajectory in theh configuration space to follow the wire
%             %
%             % INPUTS
%             % wire:3 x n matrix where n = number of points in the wire
%             % initial_thetas: dof x 1 vector
%             % initial_link_extensions: dof x 1 vector
%             %
%             % OUTPUTS
%             % joint_angles: n x m matrix of joint angles along the trajectory, 
%             % where n = number joints, m = number points in trajactory.
%             % link_extensions: n x m matrix of link extensions for prismatic links
%             % This value is ignored for links that are not prismatic
%             % joint_torques: n x m matrix of joint torques computed at the corresponding
%             % configurations along the trajectory
%             % link_torques: n x m matrix of prismatic link torques. (Leave 0 for
%             % links that are not prismatic)
%             
%             
%             joint_angles = zeros(obj.dof,size(wire,2));
%             link_extensions = zeros(obj.dof,size(wire,2));
%             joint_torques = zeros(obj.dof,size(wire,2));
%             link_torques = zeros(obj.dof,size(wire,2));
%             
%             target = wire(:,1);
%             %input = [initial_thetas,initial_link_extensions];
%             input = [initial_thetas(1:3),initial_link_extensions(1:3)];
%             
%             %h = @(q) cost(q,target,obj.link_vectors,obj.joint_axes);
%             %h = @(q) cost2(q,target,obj.link_vectors,obj.joint_axes,initial_link_extensions,obj.prismatic);
%             h = @(input) cost3(input,target,obj.link_vectors(1:3),obj.joint_axes(1:3),obj.prismatic(1:3),obj.ring_radius);
%             q = fmincon(h,input,[],[]);
%             joint_angles(1:3,1) = q(1:3,1);
%             link_extensions(1:3,1) = q(1:3,2);
%             z = [0;0;1];
%             for i = 2:size(wire,2)
%                 target = wire(:,i);
%                 input = q;
%                 %h = @(q) cost(q,target,obj.link_vectors,obj.joint_axes);
%                 %h = @(q) cost2(q,target,obj.link_vectors,obj.joint_axes,initial_link_extensions,obj.prismatic);
%                 h = @(input) cost3(input,target,obj.link_vectors(1:3),obj.joint_axes(1:3),obj.prismatic(1:3),obj.ring_radius);
%                 q = fmincon(h,input,[],[]);
%                 joint_angles(1:3,i) = q(1:3,1);
%                 link_extensions(1:3,1) = q(1:3,2);
%                 
%                 %z = [0;0;1]
%                 if i < size(wire,2)
%                     diff = (wire(:,i+1) - wire(:,i));
%                     dir = diff/norm(diff)
%                     if isnan(dir(1))
%                         continue
%                     end
%                     x = dir(1);
%                     y = dir(2);
%                     z = dir(3);
%                    
%                     if abs(z) > 0.8
%                         joint_angles(4:6,i) = [pi/2;0;0];  
%                     elseif abs(z)<0.1
%                         joint_angles(4:6,i) = [0;0;0];
%                     elseif abs(x) < 0.1
%                         if  z > 0
%                             joint_angles(4:6,i) = [pi/2;-pi/4;0];
%                         elseif z < 0
%                             joint_angles(4:6,i) = [pi/2;pi/4;0];
%                         end
%                     elseif abs(y) < 0.1
%                         if  z > 0
%                             joint_angles(4:6,i) = [pi/2;0;pi/4];
%                         elseif z < 0
%                             joint_angles(4:6,i) = [pi/2;0;-pi/4];
%                         end
%                     else
%                         joint_angles(4:6,i) = [0;0;0];
%                     end
%                     
% %                     R = [dot(z,dir) -norm(cross(z,dir)) 0; norm(cross(z,dir)) dot(z,dir) 0; 0 0 1];
% %                     joint_angles(4:6,i) = rotm2eul(R,'ZYZ');
%                 end
%                  
%                   
% %                          
%             end
%             
% 
%             
%             
%         end