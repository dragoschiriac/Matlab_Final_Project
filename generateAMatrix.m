% Function to generate the A matrix for the two-material bin
function A = generateAMatrix_3(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp)

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
for r = 1:N
    for c = 1:M
        
        % Get the number of this element, from 1..(N*M)
        i = (r-1)*M + c;
        
        if (S(r,c)==1)% we are a metal element %%%%%%NEW CODE%%%%%%%%%

            % *** Look to cell above this cell ***
            if (r == 1)  % element is on top edge (metal - environment)
                A(i, i) = A(i, i) - h*dx/km;
            elseif (S(r-1,c) == 3)    % element on the boundary of the pipe (direct heat source)    
                A(i, i) = A(i, i); % - Win*dx/(km*Pp*Lz)
            elseif (S(r-1,c) == 1)  % both elements are in interior metal-metal
                A(i, i) = A(i, i) - 1;
                A(i, i-N) = A(i, i-N) + 1;
            elseif  (S(r-1,c) == 2) %element is below fluid (metal-fluid)%%%NEW CODE%%%
                A(i,i) = A(i,i) - h*dx/km;
                A(i, i-N) = A(i, i-N) + h*dx/km;
            end
            
            % *** Look to the cell to the right of this cell ***
            if (c == M)  % element is on right edge (metal - environment)
                A(i, i) = A(i, i) - h*dx/km;
            elseif (S(r,c+1) == 3) % element on the boundary of the pipe (direct heat source)
                A(i, i) = A(i, i) ;% - Win*dx/(km*Pp*Lz)
            elseif  (S(r,c+1) == 1)% both elements are in interior (metal-metal)
                A(i, i) = A(i, i) - 1;
                A(i, i+1) = A(i, i+1) + 1;
            elseif (S(r,c+1) == 2) % element to the right is fluid%%%NEW CODE%%%
                A(i, i) = A(i, i) - h*dx/km;
                A(i, i+1) = A(i, i+1) + h*dx/km;

            end

            % *** Look to the cell to the left of this cell ***
            if (c == 1)  % element is on left edge (meta- environment)
                A(i, i) = A(i, i) - h*dx/km;
            elseif (S(r,c-1) == 3)  % element on the boundary of the pipe (direct heat source)  
                A(i, i) = A(i, i) ; % - Win*dx/(km*Pp*Lz)
            elseif (S(r,c-1) == 1)  % both elements are in interior (metal-metal)
                A(i, i) = A(i, i) - 1;
                A(i, i-1) = A(i, i-1) + 1;
            elseif (S(r,c-1) ==2) %element to left is fluid%%%NEW CODE%%%
                A(i, i) = A(i, i) - h*dx/km;
                A(i, i-1) = A(i, i-1) + h*dx/km;
                
            end

            % *** Look to cell below this cell ***
            if (r == N)  % element is on bottom edge
                A(i, i) = A(i, i) - h*dx/km;
            elseif (S(r+1,c) == 3) % element on the boundary of the pipe
                A(i, i) = A(i, i) ; % - Win*dx/(km*Pp*Lz)
            elseif (S(r+1,c) == 1)  % both elements are in interior (metal-metal)
                A(i, i) = A(i, i) - 1;
                A(i, i+N) = A(i, i+N) + 1;
            elseif (S(r+1,c) ==2) %element to left is fluid%%%NEW CODE%%%
                A(i, i) = A(i, i) - h*dx/km;
                A(i, i+N) = A(i, i+N) + h*dx/km;
            end
        
        elseif (S(r,c)==2) %We are a fluid element %%%NEW CODE%%%
            
            
            % *** Look to cell above this cell ***
            if (r == 1)  % element is on top edge (fluid - environment)
                A(i, i) = A(i, i) - ke/km;
            elseif (S(r-1,c) == 3)    % element on the boundary of the pipe (direct heat source)    
                A(i, i) = A(i, i); % - Win*dx/(km*Pp*Lz)
            elseif (S(r-1,c) == 1)  % both elements are in interior cell above is metal (fluid-metal)
                A(i, i) = A(i, i) - h*dx/km;
                A(i, i-N) = A(i, i-N) + h*dx/km;
            elseif (S(r-1,c) == 2) %element above is fluid (fluid-fluid)
                A(i, i) = A(i, i) - ke/km;
                A(i, i-N) = A(i, i-N) + ke/km;
            end
            
            % *** Look to the cell to the right of this cell ***
            if (c == M)  % element is on right edge
                A(i, i) = A(i, i) - ke/km;
            elseif (S(r,c+1) == 3) % element on the boundary of the pipe
                A(i, i) = A(i, i) ;% - Win*dx/(km*Pp*Lz)
            elseif (S(r,c+1) == 1)  % both elements are in interior cell above is metal (fluid-metal)
                A(i, i) = A(i, i) - h*dx/km;
                A(i, i+1) = A(i, i+1) + h*dx/km;
            elseif (S(r,c+1) == 2) %element above is fluid (fluid-fluid)
                A(i, i) = A(i, i) - ke/km;
                A(i, i+1) = A(i, i+1) + ke/km;
            end
            

            % *** Look to the cell to the left of this cell ***
            if (c == 1)  % element is on left edge
                A(i, i) = A(i, i) - ke/km;
            elseif (S(r,c-1) == 3)  % element on the boundary of the pipe   
                A(i, i) = A(i, i) ; % - Win*dx/(km*Pp*Lz)
            elseif (S(r,c-1) == 1)  % both elements are in interior cell above is metal (fluid-metal)
                A(i, i) = A(i, i) - h*dx/km;
                A(i, i-1) = A(i, i-1) + h*dx/km;
            else %(S(r,c-1) == 2) element above is fluid (fluid-fluid)
                A(i, i) = A(i, i) - ke/km;
                A(i, i-1) = A(i, i-1) + ke/km;
            end
            
            % *** Look to cell below this cell ***
            if (r == N)  % element is on bottom edge
                A(i, i) = A(i, i) - ke/km;
            elseif (S(r+1,c) == 3) % element on the boundary of the pipe
                A(i, i) = A(i, i) ; % - Win*dx/(km*Pp*Lz)
            elseif (S(r+1,c) == 1)  % both elements are in interior cell above is metal (fluid-metal)
                A(i, i) = A(i, i) - h*dx/km;
                A(i, i+N) = A(i, i+N) + h*dx/km;
            else %(S(r+1,c) == 2) element above is fluid (fluid-fluid)
                A(i, i) = A(i, i) - ke/km;
                A(i, i+N) = A(i, i+N) + ke/km;
            end
        end
        % If we are a pipe element, set T_i = 20
        if (S(r, c) == 3) % we are a pipe element
            A(i, :) = 0;
            A(i, i) = 1;
        end
    end % next column in S
end % next row in S

