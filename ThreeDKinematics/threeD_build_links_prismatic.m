function link_set = threeD_build_links_prismatic(link_vectors,link_extensions,prismatic)
% Take a set of link vectors and create a cylinder pointing in the
% direction of that link. If the link is prismatic, represent the link
% using two cylinders:
%   The base of the link is a cylinder that is 3/4 the length of the
% zero-extension link length.
%   The moving part of the link is a cylinder 1/2 the diameter of the
% base-cylinder for the link, 1/2 as long as the zero-extension link
% length, and offset along the link vector by 1/2 the zero-extension
% length, plus the link extension
%
% Input:
%
%   link_vectors: A 1xn cell array in which each entry is a 3x1 link vector
%   
% Output:
% 
%   link_set: A cell array the same size as link_vectors in which each
%       entry is itself a cell array whose entries are the X,Y, and Z point
%       matrices for a hexagonal prism shell around the link vector. 
%           If the link is prismatic, these the X, Y, and Z matrices should
%       be built by first constructing them for the individual link
%       pieces, and then combining them into a single matrix for each
%       component, using a column of NaN values to separate them.

    %%%%%%%%%%%%%%
    % Use the 'cell' 'and 'size' commands to create an empty cell array the
    % same size as link_vectors, named 'link_set'
    link_set = cell(size(link_vectors));

    %%%%%%%%%%%
    % Create a hexagonal prism with unit radius, oriented along the x axis
    % (use the cylinder command with radius 1 and 6 points around the
    % circumference). Setting the outputs as [Z,Y,X] makes the cylinder axis
    %   parallel with the x direction.
    [Z,Y,X] = cylinder(1,6);
    
    %%%%%%%%%%%%%%
    % Loop over vectors in link_set, scaling and stretching the basic link
    % shape to fit each link. Prismatic links can be drawn as two cylinders
    % with different radius.
    %   This can be achieved by:
    %
    %   1. Using the function 'norm' to get the length of the link vector
    %   for that link, saving this value into a variable named 'link_length'
    %
    %   2. Checking the 'prismatic' value for this link. If it is 0 (a rigid
    %   link), then
    %
    %       A. Scale the cylinder along its axis by multiplying its X
    %           points by link_length
    %
    %       B. Scale the radius of the cylinder by multiplying its Y and Z
    %          points by link_length/20
    %       
    %       C. Save the X,Y, and Z values as a cell array named 'link'
    %       
    %    If it is 1 (an extendable link), then
    %
    %       A. Scale the cylinder along its axis by multiplying its X
    %           points by 3/4 * link_length
    %
    %       B. Scale the radius of the cylinder by multiplying its Y and Z
    %          points by link_length/20
    %
    %       C. Generate a second copy of the cylinder, and scale it along
    %          its axis by multiplying its X points by 1/2 * link_length
    %
    %       D. Scale the radius of the second cylinder by multiplying its Y
    %          and Z points by link_length/40
    %
    %       E. Add link_length/2 + the extension of the link to the X value of the
    %          cylinder to place this moving portion of the link
    %
    %       F. Combine the two sets of X points into a single matrix with a
    %          column of NaN values between them. Do the same for the Y and
    %          Z sets
    %
    %       G. Save the X,Y, and Z values as a cell array named 'link'
    %
    %   4. Using the function 'orthonormal_basis_from_vector' (provided
    %   with the course materials) to generate a rotation matrix 'B' whose
    %   first column is aligned with the link vector
    %
    %   5. Using rotate_surface and the B matrix on the 'link' cell array
    %   to align the cylinder with the link vector, and then save the
    %   result as a cell array inside the corresponding cell of 'link_set'
    for i = 1:numel(link_set)
        link_length = norm(link_vectors{i});
        if(prismatic(i) == 0)
            scale = link_length/20;
            Xscale = X*link_length;
            Yscale = Y*scale;
            Zscale = Z*scale;
            link = {Xscale,Yscale,Zscale};
        else
            scale = link_length/20;
            Xscale = X*link_length*3/4;
            Yscale = Y*scale;
            Zscale = Z*scale;
            
            Xcopy = X * 1/2 * link_length;
            Ycopy = Y * link_length/40;
            Zcopy = Z * link_length/40;
            Xcopy = Xcopy + link_length/2 + link_extensions(i);
            
            spacer = zeros(size(Xscale,1),1);
            
            Xnew = [Xscale spacer Xcopy];
            Ynew = [Yscale spacer Ycopy];
            Znew = [Zscale spacer Zcopy];
            
            link = {Xnew,Ynew,Znew};
        end
        
        B = orthonormal_basis_from_vector(link_vectors{i});
        link_set{i} = rotate_surface(link,B);
    end
    
    % Loop over each link vector
        
        % Get the length of the vector using 'norm'

        % Create a rotation matrix whose first column is aligned with the
        % link vector using 'orthonormal_basis_from_vector'
       
        % If the link is prismatic

            % Make a set of X_base, Y_base, and Z_base matrices for the
            % first part of the link that scale the generic X, Y, and Z
            % matrices by 3/4 the link length in X and 1/20 the link length
            % in Y and Z

            % Make a set of X_piston, Y_piston, and Z_piston matrices for the
            % second part of the link that scale the generic X, Y, and Z
            % matrices by 1/2 the link length in X and 1/40 the link length
            % in Y and Z
            
            
            % Add half the link length plus the link's extension to the
            % X_piston value to position it


            % Create a "spacer" that is a column of NaN values with same
            % number of rows as the cylinder coordinate matrices

            % Make combined X_link, Y_link, and Z_link matrices whose
            % columns are the base matrices, the spacer, and the piston
            % matrices


           
        % Else (for non-prismatic links)
            
            % Make X_link, Y_link, and Z_link matrices by scaling X by the
            % link length, and Y and Z by 1/20 the link length

            
            

        
        % Place the X_link, Y_link, and Z_link matrices into a cell array
        % named 'link'
        
        % Rotate the prism points by the orthogonal basis (to line up what
        % we were calling the x direction with the actual link vector)


end