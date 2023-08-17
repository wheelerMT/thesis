% Grid points
nx = 128;
ny = 128;

% Spinor components
zetaP2 = sqrt(2 / 3) * ones(nx, ny);
zetaP1 = zeros(nx, ny);
zeta0 = zeros(nx, ny);
zetaM1 = ones(nx, ny);
zetaM2 = sqrt(1 / 3) * zeros(nx, ny);

% discretize sphere surface
resolution = 100;
delta = pi/resolution;
theta = 0:delta:pi; % altitude
phi = 0:2*delta:2*pi; % azimuth
[phi,theta] = meshgrid(phi,theta);

% Spin-2 spherical harmonics
Y_2p2 = 0.25 * sqrt(15 / (2*pi)).* exp(2j * phi).* sin(theta).^2;
Y_2p1 = -0.5 * sqrt(15 / (2*pi)) * exp(1j * phi).* sin(theta).*cos(theta);
Y_2p0 = 0.25 * sqrt(5 / pi) * (3 * cos(theta).^2 - 1);
Y_2m1 = 0.5 * sqrt(15 / (2*pi)) * exp(-1j * phi).* sin(theta).*cos(theta);
Y_2m2 = 0.25 * sqrt(15 / (2*pi)).* exp(-2j * phi).* sin(theta).^2;

% Plot spherical harmonic
zsph = zetaP2(64, 64).* Y_2p2 ...
    + zetaP1(64, 64).* Y_2p1 ...
    + zeta0(64, 64).* Y_2p0 ...
    + zetaM1(64, 64).* Y_2m1 ...
    + zetaM2(64, 64).* Y_2m2;

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
exportgraphics(gca, '../../../thesis_tikz/gfx/C2-spherical.pdf');

