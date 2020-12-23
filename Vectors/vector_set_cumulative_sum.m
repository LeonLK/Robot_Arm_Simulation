function v_set_s = vector_set_cumulative_sum(v_set)
% Take the cumulative sum of a set of vectors.
%
% Inputs:
%
%   v_set: a 1xn cell array, each element of which is a 2x1 or 3x1 vector
%
% Output:
%
%   v_set_s: a 1xn cell array, each element of which is a 2x1 or 3x1 vector
%       and is the cumulative sum of vectors from v_set

    %%%%%%%%
    % Start by copying v_set into a new variable v_set_s;
    
    %%%%%%%%
    % Loop over v_set_s, adding each vector to the next vector
    v_set_s = v_set;
    for i = 1:max(size(v_set))
        if i > 1
            v_set_s{i} = v_set_s{i-1} + v_set{i};
        else
            v_set_s{i} = v_set{i};
        end 
    end

end