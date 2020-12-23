function cost = costFun(joint_config,target,RingBot)
%COST Summary of this function goes here
% target = each wire position. Desired postion of the non decoupling part.
%   Detailed explanation goes here
    cost = 0.5 * (FK(link_vectors,joint_angles,joint_axes)

end

