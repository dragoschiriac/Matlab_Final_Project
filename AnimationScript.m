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

T_avg = ones(47,1)*100;
perMat = zeros(47,1);
T_max = ones(47,1)*100;
T_min = zeros(47,1);

for(i = 1:47)
    if (i <= 20)
        S(10:12,i) = 2;
        S(20:22,i) = 2;
        S(40:42,i) = 2;
        S(60:62,i) = 2;
        S(10:12,76-i) = 2;
        S(20:22,76-i) = 2;
        S(40:42,76-i) = 2;
        S(57:60,76-i) = 2;
    end
    if (i > 20)
        if (i <= 30)
            S(76-i+20,11:15) = 2;
            S(76-i+20,61:65) = 2;
        end
        S(76-i+20,23:25) = 2;
        S(76-i+20,30:35) = 2;
        S(76-i+20,48:53) = 2;
    end
    
    
    subplot(2,3,[1,2,4,5])
    Tm = plotTemperatures(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);
    indices = find(S == 2 | S==3);
    Tm(indices) = [];
    z = size(Tm);
    T_avg(i) = sum(Tm)/(z(2));
    perMat(i) = 1 - z(2)/((75^2)*0.96);
    T_max(i) = max(Tm(:));
    T_min(i) = min(Tm(:));
    
    
    
    
    
    subplot(2,3,3)
    plot(perMat, T_max, '.');
    xlim([0 0.2])
    ylim([40 60])
    title(['Maximum temperature = ', num2str(T_max(i))])
    %text(0.05, 43, ['smallest maximum temp'])
    if (T_max(i) == min(T_max))
        text(0.05, 43, ['smallest maximum temp'])
    end
    
    
    subplot(2,3,6)
    plot(perMat, T_avg, '.');
    xlim([0 0.2])
    ylim([30 50])
    title(['Average temperature = ', num2str(T_avg(i))])
    if (T_avg(i) == min(T_avg))
        text(0.05, 43, ['smallest average temp'])
    end
    
    F(i) = getframe;
   
    
end





