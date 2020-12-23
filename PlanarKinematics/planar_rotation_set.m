function R_set = planar_rotation_set(joint_angles)
% Generate a set of planar rotation matrices corresponding to the angles in
% the input vector
%
% Input:
%
%   joint_angles: a 1xn or nx1 vector of joint angles
%
% Output:
%
%   R_set: a cell array of the same size as the vector angles, in which
%       each cell contains the planar rotation matrix for the angle in the
%       corresponding entry of the vector

    %%%%%%%
    % First, create an empty cell array called R_set that is the same size
    % as the vector of joint angles, using the 'cell' and 'size' functions
 
    %%%%%%%
    % Loop over the joint angles, creating a rotation matrix and placing it
    % in the corresponding entry of R_set
    
    R_set = cell(size(joint_angles));
    for i = 1:max(size(joint_angles))
        if isrow(joint_angles)
            R_set{1,i} = R_planar(joint_angles(i)); 
        elseif iscolumn(joint_angles)
            R_set{i,1} = R_planar(joint_angles(i));
        end

        
    end
    
                

end