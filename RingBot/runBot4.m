%link_vectors = {[0;0;0.6],[0;0;3],[0;0;2.48528],[0;0;0.01],[0;0;0.01],[0;0;0.01]}; % TODO
link_vectors = {[0;0;0.6],[0;0;1.5],[0;0;1.5],[0;1;0],[0;0.01;0],[0;0.01;0],[0;0.01;0]}; % TODO
%joint_axes = {'z','x','x','z','y','x'}; %TODO
joint_axes = {'z','x','x','y','y','x','y'};
link_colors = ['k','b','r','k','r','b','r','g'];%TODO
prismatic = [0;0;0;1;0;0;0]; %TODO

robot = RingBot(link_vectors,joint_axes,prismatic, link_colors);
load('Wires/wire1.mat', 'wire');

% Initial values for joint angles and link extensions
joint_angles = [0;1/2;-1/2;0;0;0;0]*pi;% TODO
link_extensions = [0;0;0;2;0;0;0];%TODO
visualizeTrajectory(robot, wire, joint_angles, link_extensions);
%visualizeTrajectory(robot, wire, joint_angles, link_extensions);


