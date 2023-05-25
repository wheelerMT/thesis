nx = 128;
ny = 128;
dx = 20 / nx;
dy = 20 / ny;

% Grids
x = (-nx/2:nx/2-1) * dx;
y = (-ny/2:ny/2-1) * dy;
[X, Y] = meshgrid(x, y);
r = sqrt(X.^2 + Y.^2);

% Eurler angles
beta = pi / 4 * (1 + tanh(r - 1));
varphi = atan2(Y, X);

% Spinor
zetaP1 = cos(beta/2).^2;
zeta0 = exp(1i * varphi) / sqrt(2.0).* sin(beta);
zetaM1 = exp(2i*varphi).*sin(beta/2).^2;

% discretize sphere surface
resolution = 100;
delta = pi/resolution;
theta = 0:delta:pi; % altitude
phi = 0:2*delta:2*pi; % azimuth
[phi,theta] = meshgrid(phi,theta);

% Spin-1 spherical harmonics
Y_1p1 = -0.5 * sqrt(3 / (2 * pi)) * exp(1i * phi).* sin(theta);
Y_1p0 = 0.5 * sqrt(3 / pi) * cos(theta);
Y_1m1 = 0.5 * sqrt(3 / (2 * pi)) * exp(-1i * phi).* sin(theta);

scale = 2;

%% First ring
lower_x_lim = 48;
middle_x_lim = 64;
upper_x_lim = 80;
lower_y_lim = 48;
middle_y_lim = 64;
upper_y_lim = 80;
plot_angle = 0;
radius = 7;

for i = lower_x_lim:5:upper_x_lim
    for j = lower_y_lim:5:upper_y_lim
        zsph = zetaP1(i, j).* Y_1p1 ...
        + zeta0(i, j).* Y_1p0 ...
        + zetaM1(i, j).* Y_1m1;
        
        xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
            + X(i, j);
        yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
            + Y(i, j);
        zz = scale * abs(zsph).^2.*cos(theta);
        
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
view(0, 40);
exportgraphics(gca, '../../gfx/ch-groundStateSymmetries/coreless.pdf')