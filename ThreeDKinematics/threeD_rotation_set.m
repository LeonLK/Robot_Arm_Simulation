function R_set = threeD_rotation_set(joint_angles,joint_axes)
% Generate a set of planar rotation matrices corresponding to the angles
% and axes in the input vector
%
% Inputs:
%
%   joint_angles: a 1xn or nx1 vector of joint angles
%
%   joint_axes: a cell array of the same size as joint_angles, each element
%       of which is a one-character string 'x','y', or 'z' that specifies
%       which axis the rotation is around
%
% Output:
%
%   R_set: a cell array of the same size as the vector joint_angles, in
%       which each cell contains the planar rotation matrix for the angle
%       in the corresponding entry of the vector

    %%%%%%%%
    % Start by creating an empty cell array of the same size as joint_angles,
    % named 'R_set'
    R_set = cell(size(joint_angles));
    
    %%%%%%%%
    % Loop over the joint angles
        
        %%%%%%%
        % Use 'switch/case' to check which axis that joint angle is
        % around. For 'x','y', or 'z', this should result in calling the
        % appropriate rotation matrix and saving the output in R_set{idx}.
        %
        % Any other string should trigger the 'otherwise' part of
        % switch/case, in which there should be an 'error' function that
        % tells the user what they did wrong. For example, 
        %
        % error([joint_axis ' is not a known joint axis'])
        % 
        % would make the program stop, and tell the user what string was
        % incorrectly supplied as the description of a rotation matrix.
    for i = 1:numel(joint_angles)
        n = joint_axes{i};
        switch n
            case 'x'
                R_set{i} = Rx(joint_angles(i));
            case 'y'
                R_set{i} = Ry(joint_angles(i));
            case 'z'
                R_set{i} = Rz(joint_angles(i));
            otherwise
                error([joint_axis ' is not a known joint axis']);
        end
    end
    

                

end