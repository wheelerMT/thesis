% Grid points
nx = 128;
ny = 128;

% Constants
p = 0.9;
c1 = 1;
n = 1;

% Spinor components
zetaP1 = ones(nx, ny);
zeta0 = zeros(nx, ny);
zetaM1 = zeros(nx, ny);

% discretize sphere surface
resolution = 250;
delta = pi/resolution;
theta = 0:delta:pi; % altitude
phi = 0:2*delta:2*pi; % azimuth
[phi,theta] = meshgrid(phi,theta);

% Spin-1 spherical harmonics
Y_1p1 = -0.5 * sqrt(3 / (2 * pi)) * exp(1i * phi).* sin(theta);
Y_1p0 = 0.5 * sqrt(3 / pi) * cos(theta);
Y_1m1 = 0.5 * sqrt(3 / (2 * pi)) * exp(-1i * phi).* sin(theta);

% Plot spherical harmonic
zsph = zetaP1(64, 64).* Y_1p1 ...
    + zeta0(64, 64).* Y_1p0 ...
    + zetaM1(64, 64).* Y_1m1;

scale = 1.0;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi);
yy = abs(zsph).^2.*sin(theta).*sin(phi);
zz = abs(zsph).^2.*cos(theta);

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
axis off;
colormap(hsv);
clim([-pi pi]);
camlight left
camlight right
lighting phong
daspect([1 1 1]);
view(-23, 30);

exportgraphics(gca, '../../../thesis_tikz/gfx/FM-spherical.pdf');

