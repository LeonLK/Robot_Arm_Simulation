function link_set = planar_place_links(links_in_world,link_end_set_with_base)
% Use the locations of the ends of a set of links to place the
% start-and-end matrices for the links
%
% Inputs:
%
%   links_in_world: a 1xn cell array, each element of which is a matrix
%       whose columns are the start-and-end points of the link in its
%       rotated-but-not-translated frame
%
%   link_end_set_with_base: a 1x(n+1) cell array, each element of which is
%       a vector containing the world location of the end of the
%       corresponding link
%
% Output:
%
%   link_set: a 1xn cell array, each element of which is a 2xn matrix
%       whose columns are the start-and-end points of the link
%       after the link has been placed in the world

    %%%%%%%%
    % Start by copying links_in_world into a new variable named 'link_set';
    link_set = links_in_world;
    
    %%%%%%%%
    % Loop over link_end_set, adding each the location of the base of each
    % link to its endpoint matrix
    n = numel(link_set);

    for i = 1:numel(link_set)
         link_set{i} = link_set{i} + link_end_set_with_base{i};
    end
        

end