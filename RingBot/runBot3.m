link_vectors = {[0;0;0.6],[0;0;1.5],[0;0;1.5],[0;0;1.5],[0;0;1.5],[0;0;0.01],[0;0;0.01],[0;0;0.01]}; % TODO
%link_vectors = {[0;0;0.6],[0;0;3],[0;0;2.48528],[0;0.01;0],[0;0.01;0],[0;0.01;0]}; % TODO
joint_axes = {'z','x','x','x','x','z','y','x'}; %TODO
%joint_axes = {'z','x','x','x','y','x'};
link_colors = ['k','b','r','b','r','k','b','r','g'];%TODO
prismatic = [0;0;0;0;0;0;0;0]; %TODO

robot = RingBot(link_vectors,joint_axes,prismatic, link_colors);
load('Wires/wire3.mat', 'wire');

% Initial values for joint angles and link extensions
joint_angles = [0;1/2;-1/2;0;0;0;0;0]*pi;% TODO
link_extensions = [0;0;0;0;0;0;0;0];%TODO
visualizeTrajectory(robot, wire, joint_angles, link_extensions);
%visualizeTrajectory(robot, wire, joint_angles, link_extensions);


