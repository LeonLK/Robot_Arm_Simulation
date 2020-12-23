function c = cost(q,target,link_vectors,joint_axes)
    [link_ends,~,~,~,~,~] = threeD_robot_arm_endpoints(link_vectors,q,joint_axes);
    ee = link_ends(:,end);
    c = 0.5*((ee-target)')*(ee-target);
end

