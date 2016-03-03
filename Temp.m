% Create an empty matrix A
clc
close all;
N = 5;

A = zeros(25, 25);
B = zeros(25, 1);

% Put the non-zero values into A

% put -4's down diagonal
for ( i = 1:25)
    A(i, i) = -4;
end

for (i = 1:5:25)
    A(i,i) = -3;
end

% Add 1's above -4s
for (i = 1:25)
    if (A(i,i) == -4)
        A(i-1, i) = 1; % up one row
        A(i, i-1) = 1; % one to the left
    end
end

% 1's 5 away from diagonal
for (i = 1:25)
    A(i+5, i) = 1;  % put 1's 5 rows down
    A(i, i+5) = 1;   % put 1's 5 cols to right
end

% Take the upper 25 x 25 part of A
A = A(1:25, 1:25)
% disp(A)



% Put the non-zero values into B
% -5 in first 5 spots
for (i = 1:5)
    B(i) = B(i) -20;
end

for (i = 5:5:25)
    B(i) = B(i) -120;
end
disp(B)

for (i = 21:25)
    B(i) = B(i) - 100;
end

T = A \ B

% Make into 5x5 matrix
Tm = reshape(T, 5, 5)'

[x, y] = meshgrid( linspace(0, 1, 5), linspace(1, 0, 5))
pcolor(x, y, Tm)
colorbar

