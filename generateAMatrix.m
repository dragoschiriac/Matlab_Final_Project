% Function to generate the A matrix for the two-material bin
function A = generateAMatrix(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp)

% Set a default A matrix the correct size (DxD = (NM) x (NM))
N = size(S, 1);
M = size(S, 2);
D = N*M;
A = sparse(D, D);

% Compute the size of the elements
dx = Lx / M;
dy = dx;

% Ensure plate has same dx and dy scale
if (abs(Ly/Lx - N/M) > 1e-5)
    error(sprintf('Dim ratio is %.4f, while N/M ratio is %.4f\n', Ly/Lx, N/M));
end

% The material marix M has either 1's, 2's or 3's in it
if (max(max(S)) > 3 |  min(min(S)) < 1)
    error('Can only have three material types (1 = metal, 2 = fluid, 3 = pipe)\n')
    return;
end

% Loop over the cells in the given plate, using r & c/row & column
for (r = 1:N)
    for (c = 1:M)
        % Get the number of this element, from 1..(N*M)
        i = (r-1)*M + c;
        
        % *** Look to cell above this cell ***
        if (r == 1)  % element is on top edge
            A(i, i) = A(i, i) - h*dx/km;
        elseif (S(r-1,c) == 3)    % element on the boundary of the pipe    
            A(i, i) = A(i, i); % - Win*dx/(km*Pp*Lz)
        else  % both elements are in interior
            A(i, i) = A(i, i) - 1;
            A(i, i-N) = A(i, i-N) + 1;
        end
        
        % *** Look to the cell to the right of this cell ***
        if (c == M)  % element is on right edge
            A(i, i) = A(i, i) - h*dx/km;
        elseif (S(r,c+1) == 3) % element on the boundary of the pipe
            A(i, i) = A(i, i) ;% - Win*dx/(km*Pp*Lz)
        else  % both elements are in interior
            A(i, i) = A(i, i) - 1;
            A(i, i+1) = A(i, i+1) + 1;
        end
        
        % *** Look to the cell to the left of this cell ***
        if (c == 1)  % element is on left edge
            A(i, i) = A(i, i) - h*dx/km;
        elseif (S(r,c-1) == 3)  % element on the boundary of the pipe   
            A(i, i) = A(i, i) ; % - Win*dx/(km*Pp*Lz)
        else  % both elements are in interior
            A(i, i) = A(i, i) - 1;
            A(i, i-1) = A(i, i-1) + 1;
        end
        
        % *** Look to cell below this cell ***
        if (r == N)  % element is on bottom edge
            A(i, i) = A(i, i) - h*dx/km;
        elseif (S(r+1,c) == 3) % element on the boundary of the pipe
            A(i, i) = A(i, i) ; % - Win*dx/(km*Pp*Lz)
        else  % both elements are in interior
            A(i, i) = A(i, i) - 1;
            A(i, i+N) = A(i, i+N) + 1;
        end

        % If we are a pipe element, set T_i = 20
        if (S(r, c) == 3) % we are a pipe element
            A(i, :) = 0;
            A(i, i) = 1;
        end
    end % next column in S
end % next row in S
