function R_set_c = rotation_set_cumulative_product(R_set)
% Take the cumulative product of a set of rotation matrices
%
% Input:
%
%   R_set: A 1xn cell array, each element of which is a 2x2 or 3x3 rotation
%       matrix
%
% Output:
%
%   R_set_c: A 1xn cell array, the ith element of which is a 2x2 or 3x3 rotation
%       matrix that is the cumulative product of the rotation matrices in
%       R_set from the first matrix up to the ith matrix


    %%%%%%
    % Start by copying R_set into a new variable R_set_c;
    
    %%%%%%
    % Loop over R_set_c, multiplying each matrix by the one before it
R_set_c = cell(size(R_set));
for i = 1:max(size(R_set))
    if i > 1
        R_set_c{i} = R_set_c{i-1}*R_set{i};
    else
        R_set_c{i} = R_set{i};
    end 
end

end