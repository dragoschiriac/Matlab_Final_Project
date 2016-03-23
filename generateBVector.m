% Function to generate the B vector for the fin
function B = generateBVector(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp)

% Set a default A matrix the correct size (DxD = (NM) x (NM))
N = size(S, 1);
M = size(S, 2);
D = N*M;

% Create B
B = zeros(D, 1);

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

% Loop over the grid points in the given S, using r & c
for (r = 1:N)
    for (c = 1:M)
        % Get the number of this element, from 1..N*M
        i = (r-1)*M + c;
        % *** Look to cell above this cell ***
        if (r == 1)  % element is on top edge
            if(S(r,c) == 2) %if the element is fluid
                B(i) = B(i) - ke*(Tinf)/km;
            else %the element is metal
                B(i) = B(i) - h*(Tinf)*dy/km;
            end
        elseif (S(r-1,c) == 3) % on the edge of the pipe
            B(i)= B(i)- Win*dx/(km*Pp*Lz);
        else % both elements are in interior 
            B(i)= B(i)- 0;
        end
        
        % *** Look to the cell to the right of this cell ***
        if (c == M)  % element is on right edge
            if(S(r,c) == 2) %if the element is fluid
                B(i) = B(i) - ke*(Tinf)/km;
            else %if the element is metal
                B(i) = B(i) - h*(Tinf)*dy/km;
            end
        elseif (S(r,c+1) == 3) % on the edge of the pipe
            B(i)= B(i)- Win*dx/(km*Pp*Lz);
        else  % both elements are in interior
            B(i)= B(i)- 0;
        end
        
        % *** Look to the cell to the left of this cell ***
        if (c == 1)  % element is on left edge
            if(S(r,c) == 2) %if the element is fluid
                B(i) = B(i) - ke*(Tinf)/km;
            else %if the element is metal
                B(i) = B(i) - h*(Tinf)*dy/km;
            end
        elseif (S(r,c-1) == 3) % on the edge of the pipe
            B(i)= B(i)- Win*dx/(km*Pp*Lz);
        else  % both elements are in interior
            B(i)= B(i)- 0;
        end
       
        
        % *** Look to cell below this cell ***
        if (r == N)  % element is on bottom edge
            if(S(r,c) == 2) %if the element is fluid
                B(i) = B(i) - ke*(Tinf)/km;
            else %if the element is metal
                B(i) = B(i) - h*(Tinf)*dy/km;
            end
        elseif (S(r+1,c) == 3) % on the edge of the pipe
            B(i)= B(i)- Win*dx/(km*Pp*Lz);
        else  % both elements are in interior
            B(i)= B(i)- 0;
        end
        
        
        
        % If we are a pipe element, set T_i = 20
        if (S(r, c) == 3) % we are a pipe element
            B(i) = 20;
        end
    end % next column in S
end % next row in S