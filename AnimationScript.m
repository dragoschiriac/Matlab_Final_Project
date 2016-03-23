close all;
clc
clear;

% Open a figure window of fixed size: feel free to change the size if you
% like
figure(1);
set(gcf, 'OuterPosition', [0 0 1024 768 ] );

% Material parameters
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

S = ones(75, 75);
% The next two lines will always put the pipe in correct location, regardless of the
% size of our grid
m = size(S,1)/5;  % find the number of units in 1/5
S((2*m+1):3*m,  (2*m+1):3*m) = 3;
[M, N] = size(S);
dx = Lx/N;

% Plot the starting design, with no cuts in it
Tm = plotTemperatures(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);
