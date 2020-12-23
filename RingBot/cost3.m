function c = cost3(input,target,link_vectors,joint_axes,prismatic,ring_radius)
    q = input(:,1);
    link_extensions = input(:,2);
    [~, ~,~,~,~,~,~,link_end_set_with_base] = threeD_links_with_ring(link_vectors,q,joint_axes,link_extensions, prismatic, ring_radius);
    ee = link_end_set_with_base{end};
    target = target - [0;0;ring_radius];
    c = 0.5*((ee-target)')*(ee-target);
    %c = norm(target-ee-ring_radius/2-0.01);
end
