close all; clear; clc;

% Phase 1 Test cases
Tinf = 20;

% Set the dimensions
Lz = 0.5;
Lx = 0.5;
Ly = 0.5;
Pp = 0.4;  %  exposed perimeter of the pipe

% Set the material properties - km for metal, ke for environment
km = 12;  % W/ (m * deg K)
ke = 8; % water conduction

% Define the convection to the environment
h = 24;  % watts / (m^2 * K)

% Set the interior source to have a Wattage input
Win = 400;

% ************ First Test Case ****************
S = ones(5, 5);
S(3, 3) = 3;
N = size(S, 1);
M = size(S, 2);
dx = Lx/M;

A = generateAMatrix(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);

A = full(A);

A_given = [-2.4 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    1 , -3.2 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 1 , -3.2 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 1 , -3.2 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 1 , -2.4 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    1 , 0 , 0 , 0 , 0 , -3.2 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 1 , 0 , 0 , 0 , 1 , -4 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 1 , 0 , 0 , 0 , 1 , -3 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -4 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -3.2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , -3.2 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -3 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , -3 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -3.2 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , -3.2 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -4 , 1 , 0 , 0 , 0 , 1 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , -3 , 1 , 0 , 0 , 0 , 1 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -4 , 1 , 0 , 0 , 0 , 1 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -3.2 , 0 , 0 , 0 , 0 , 1;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , -2.4 , 1 , 0 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -3.2 , 1 , 0 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -3.2 , 1 , 0;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -3.2 , 1;
    0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 1 , -2.4];

%A_given = sparse(A_given);

%assert(isequal(A,A_given))
for (i = 1:length(A))
    for (j = 1:length(A))
        %fprintf('A(%.0f, %.0f) = %.1f A_given(%.0f, %.0f) = %0.1f\n', i, j, A(i,j), i, j, A_given(i,j))
        %assert(abs(A(i,j) - A_given(i,j)) < 10e-5)
        if (abs(A(i,j) - A_given(i,j)) > 10e-5)
            fprintf('A(%.0f, %.0f) = %.1f A_given(%.0f, %.0f) = %0.1f\n', i, j, A(i,j), i, j, A_given(i,j))
        end
    end
end