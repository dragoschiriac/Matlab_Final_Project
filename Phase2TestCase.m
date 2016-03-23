close all;
clear;
clc;

% Phase 2 Test Case constants
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
S(2,1) = 2;
S(1:2,4) = 2;
S(4,4:5) = 2;

A = generateAMatrix(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);

A = full(A);

A_given = [-1.6 1 0 0 0 0.2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    1 -3.2 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 1 -2.4 0.2 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0.2 -1.733 0.2 0 0 0 0.6667 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0.2 -1.6 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0.2 0 0 0 0 -1.267 0.2 0 0 0 0.2 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 1 0 0 0 0.2 -3.2 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 1 0 0 0 1 -2.2 0.2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0.6667 0 0 0 0.2 -1.267 0.2 0 0 0 0.2 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 1 0 0 0 0.2 -2.4 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0.2 0 0 0 0 -2.4 1 0 0 0 1 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 0 0 0 1 -3 0 0 0 0 1 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0.2 0 0 0 0 -1.4 1 0 0 0 0.2 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 1 0 0 0 1 -2.4 0 0 0 0 0.2 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 -3.2 1 0 0 0 1 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 -4 1 0 0 0 1 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -2.2 0.2 0 0 0 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0 0 0 0.2 -1.267 0.6667 0 0 0 0.2 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0 0 0 0.6667 -1.733 0 0 0 0 0.2;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 -2.4 1 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 -3.2 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 -3.2 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0 0 0 1 -2.4 1;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 0 0 0 1 -1.6];

B = generateBVector(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);

B_given = [-8.0000;
    -4.0000;
    -4.0000;
    -13.3333;
    -8.0000;
    -13.3333;
    0.0000;
    -16.6667;
    0.0000;
    -4.0000;
    -4.0000;
    -16.6667;
    20.0000;
    -16.6667;
    -4.0000;
    -4.0000;
    0.0000;
    -16.6667;
    0.0000;
    -13.3333;
    -8.0000;
    -4.0000;
    -4.0000;
    -4.0000;
    -8.0000];

% assert(isequal(B,B_given))
for (i = 1:length(B))
    %fprintf('A(%.0f, %.0f) = %.1f A_given(%.0f, %.0f) = %0.1f\n', i, j, A(i,j), i, j, A_given(i,j))
    %assert(abs(A(i,j) - A_given(i,j)) < 10e-5)
    if (abs(B(i) - B_given(i)) > 10e-4)
        fprintf('B(%.0f) = %.1f B_given(%.0f) = %0.1f\n', i, B(i), i, B_given(i))
    end
end

%assert(isequal(A,A_given))
for (i = 1:length(A))
    for (j = 1:length(A))
        %fprintf('A(%.0f, %.0f) = %.1f A_given(%.0f, %.0f) = %0.1f\n', i, j, A(i,j), i, j, A_given(i,j))
        %assert(abs(A(i,j) - A_given(i,j)) < 10e-5)
        if (abs(A(i,j) - A_given(i,j)) > 10e-4)
            fprintf('A(%.0f, %.0f) = %.1f A_given(%.0f, %.0f) = %0.1f\n', i, j, A(i,j), i, j, A_given(i,j))
        end
    end
end