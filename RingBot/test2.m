% link_vectors = {[3;0;0],[1;0;0]}; % TODO
% joint_axes = {'x','x'}; %TODO
% link_colors = ['k','b'];%TODO
% prismatic = [0;1]; %TODO\
% ring_radius = 0;
% 
% joint_angles = [0;0]*pi;% TODO
% link_extensions = [0;1];
target = [4.5;0;0];



link_vectors = {[3;0;0],[2.5;0;0],[2;0;0],[0.1;0;0],[0.1;0;0],[0.1;0;0]}; % TODO
joint_axes = {'z','y','y','z','y','z'}; %TODO
link_colors = ['k','b','r','k','b','r','k'];%TODO
prismatic = [0;0;0;1;0;0]; %TODO

% Initial values for joint angles and link extensions
joint_angles = [0;1/4;-1/2;0;0;0]*pi;% TODO
link_extensions = [0;0;0;1;0;0];%TODO


input = [joint_angles,link_extensions];


c = cost3(input,target,link_vectors,joint_axes,prismatic,ring_radius);
%x0 = [q;link_extensions];
h = @(input) cost3(input,target,link_vectors,joint_axes,prismatic,ring_radius);
r = fmincon(h,input,[],[]);
r
r(:,1)
r(:,2)