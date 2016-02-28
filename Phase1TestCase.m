close all;
clear;
clc;

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