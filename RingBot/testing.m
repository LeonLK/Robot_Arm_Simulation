link_vectors = {[3;0;0],[2.5;0;0],[2;0;0],[0.1;0;0],[0.1;0;0],[0.1;0;0]}; % TODO
joint_axes = {'z','y','y','z','y','z'}; %TODO
link_colors = ['k','b','r','k','b','r','k'];%TODO
prismatic = [0;0;0;0;0;0]; %TODO

% Initial values for joint angles and link extensions
q = [0;1/4;-1/2;0;0;0]*pi;% TODO
link_extensions = [0;0;0;0;0;0];%TODO
target = [4.5;0;0];
c = cost(q,target,link_vectors,joint_axes)
x0 = q;
h = @(q) cost(q,target,link_vectors,joint_axes);
r = fmincon(h,x0,[],[]);
r