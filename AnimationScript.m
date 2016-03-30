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

for(i = 1:20)
    S(i,10:12) = 2;
    S(i,20:22) = 2;
    S(i,40:42) = 2;
    S(i,60:62) = 2;
    S(76-i,10:12) = 2;
    S(76-i,20:22) = 2;
    S(76-i,40:42) = 2;
    S(76-i,57:60) = 2;
    
    Tm = plotTemperatures(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);
    
    % [maxValue, linearIndexesOfMaxes] = max(A(:));
    % [rowsOfMaxes colsOfMaxes] = find(A == maxValue);
    %     T_max = max(T(:));
    %     T_min = min(T(:));
    %     text()
    F(i) = getframe;
end

for(i = 1:27)
    if(i <= 10)
        S(11:15,76-i) = 2;
        S(61:65,76-i) = 2;
    end
    S(23:25,76-i) = 2;
    S(30:35,76-i) = 2;
    S(48:53,76-i) = 2;
    Tm = plotTemperatures(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);
    F(20+i) = getframe;
end

movie(F, 1);


