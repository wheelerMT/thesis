% Create the wave function
% Create the spherical harmonics
% Map and plot spherical harmonics to circle

nx = 64;
ny = 64;
nz = 64;
dx = nx / 20;
dy = ny / 20;
dz = nz / 20;

x = (-nx/2:nx/2-1) * dx;
y = (-ny/2:ny/2-1) * dy;
z = (-nz/2:nz/2-1) * dz;
[X, Y, Z] = meshgrid(x, y, z);

rho = sqrt(X.^2 + Y.^2);
