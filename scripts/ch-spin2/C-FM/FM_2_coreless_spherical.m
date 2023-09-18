nx = 256;
ny = 256;
nz = 256;
dx = 20 / nx;
dy = 20 / ny;
dz = 20 / nz;

x = (-nx/2:nx/2-1) * dx;
y = (-ny/2:ny/2-1) * dy;
z = (-nz/2:nz/2-1) * dz;
[X, Y, Z] = meshgrid(x, y, z);

varphi = atan2(Y, X);
r = sqrt(X.^2 + Y.^2);
beta = pi/4 * (1 + tanh(r - 1));

zetaP2 = exp(-4j*varphi).*cos(beta/2).^4;
zetaP1 = 2 * exp(-3j*varphi).*cos(beta/2).^3 .* sin(beta/2);
zeta0 = sqrt(6) * exp(-2j*varphi).*cos(beta/2).^2 .* sin(beta/2).^2;
zetaM1 = 2 * exp(-1j*varphi).*sin(beta/2).^3 .* cos(beta/2);
zetaM2 = sin(beta/2).^4;

% discretize sphere surface
resolution = 100;
delta = pi/resolution;
theta = 0:delta:pi; % altitude
phi = 0:2*delta:2*pi; % azimuth
[phi,theta] = meshgrid(phi,theta);

Y_2p2 = 0.25 * sqrt(15 / (2*pi)).* exp(2j * phi).* sin(theta).^2;
Y_2p1 = -0.5 * sqrt(15 / (2*pi)) * exp(1j * phi).* sin(theta).*cos(theta);
Y_2p0 = 0.25 * sqrt(5 / pi) * (3 * cos(theta).^2 - 1);
Y_2m1 = 0.5 * sqrt(15 / (2*pi)) * exp(-1j * phi).* sin(theta).*cos(theta);
Y_2m2 = 0.25 * sqrt(15 / (2*pi)).* exp(-2j * phi).* sin(theta).^2;

z_lim = 64;
scale = 0.9;

for ii = nx /2 - 20 :6: nx / 2 + 20
    for jj = ny /2 - 20 :6: ny / 2 + 20
        zsph = zetaP2(ii, jj, z_lim).* Y_2p2 ...
        + zetaP1(ii, jj, z_lim).* Y_2p1 ...
        + zeta0(ii, jj, z_lim).* Y_2p0 ...
        + zetaM1(ii, jj, z_lim).* Y_2m1 ...
        + zetaM2(ii, jj, z_lim).* Y_2m2;
        zsph = zsph * scale;
        xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
            + X(ii, jj);
        yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
            + Y(ii, jj);
        zz = abs(zsph).^2.*cos(theta);

        h = surf(xx,yy,zz,angle(zsph));
        set(h, 'LineStyle','none')
        hold on;
    end
end

axis off;
colormap(hsv);
clim([-pi pi]);
camlight left
camlight right
lighting phong
daspect([1 1 1]);
view(0, 35);
% exportgraphics(gca, '../../../gfx/ch-spin2/FM-2-coreless.pdf', 'Resolution', 200)