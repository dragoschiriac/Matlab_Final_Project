%Function to plot
function Tm = plotTemperatures(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp)

%A = generateAMatrix(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);
%B = generateBVector(S, Win, Tinf, km, ke, h, Lx, Ly, Lz, Pp);

T = A\B;
%I have a problem because the size of matrix T is what?
N = size(S,1); %the size of matrix S is N x N

Tm = reshape(T, N, N); %might use this code

[x_axis,y_axis] = meshgrid(linspace(0,1,N),linspace(0,1,N));

pcolor(x_axis, y_axis, Tm);
axis equal %see NOTE

colorbar; %adds colour scale on side

%%%%%%%NOTE%%%%%%%%%
%axis equal sets the aspect ratio so that
% the data units are the same in every 
% direction. The aspect ratio of the x-, 
% y-, and z-axis is adjusted automatically 
% according to the range of data 
% units in the x, y, and z directions.
end