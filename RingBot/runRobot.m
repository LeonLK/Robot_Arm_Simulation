link_vectors = {[3;0;0],[2;0;0],[2;0;0],[0.01;0;0],[0.01;0;0],[0.01;0;0]}; % TODO
joint_axes = {'z','y','y','z','y','z'}; %TODO
link_colors = ['k','b','r','k','b','r','k'];%TODO
prismatic = [0;0;0;0;0;0]; %TODO

robot = RingBot(link_vectors,joint_axes,prismatic, link_colors);
load('Wires/wire1.mat', 'wire');

% Initial values for joint angles and link extensions
joint_angles = [0;1/4;-1/2;0;0;0]*pi;% TODO
link_extensions = [0;0;0;0;0;0];%TODO
visualizeTrajectory(robot, wire, joint_angles, link_extensions);
%visualizeTrajectory(robot, wire, joint_angles, link_extensions);