nx = 128;
ny = 128;
dx = 20 / nx;
dy = 20 / ny;

% Grids
x = (-nx/2:nx/2-1) * dx;
y = (-ny/2:ny/2-1) * dy;
[X, Y] = meshgrid(x, y);
r = sqrt(X.^2 + Y.^2);

% Phase
varphi = atan2(Y, X);

% Spinor
zetaP1 = -0.5 * ones(nx, ny);
zeta0 = zeros(nx, ny);
zetaM1 = exp(1i*varphi);

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
radius = 2;

zsph = zetaP1(lower_x_lim, lower_y_lim).* Y_1p1 ...
    + zeta0(lower_x_lim, lower_y_lim).* Y_1p0 ...
    + zetaM1(lower_x_lim, lower_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;


zsph = zetaP1(lower_x_lim, middle_y_lim).* Y_1p1 ...
    + zeta0(lower_x_lim, middle_y_lim).* Y_1p0 ...
    + zetaM1(lower_x_lim, middle_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP1(lower_x_lim, upper_y_lim).* Y_1p1 ...
    + zeta0(lower_x_lim, upper_y_lim).* Y_1p0 ...
    + zetaM1(lower_x_lim, upper_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP1(middle_x_lim, upper_y_lim).* Y_1p1 ...
    + zeta0(middle_x_lim, upper_y_lim).* Y_1p0 ...
    + zetaM1(middle_x_lim, upper_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP1(upper_x_lim, upper_y_lim).* Y_1p1 ...
    + zeta0(upper_x_lim, upper_y_lim).* Y_1p0 ...
    + zetaM1(upper_x_lim, upper_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP1(upper_x_lim, middle_y_lim).* Y_1p1 ...
    + zeta0(upper_x_lim, middle_y_lim).* Y_1p0 ...
    + zetaM1(upper_x_lim, middle_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP1(upper_x_lim, lower_y_lim).* Y_1p1 ...
    + zeta0(upper_x_lim, lower_y_lim).* Y_1p0 ...
    + zetaM1(upper_x_lim, lower_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP1(middle_x_lim, lower_y_lim).* Y_1p1 ...
    + zeta0(middle_x_lim, lower_y_lim).* Y_1p0 ...
    + zetaM1(middle_x_lim, lower_y_lim).* Y_1m1;
xx = scale * abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = scale * abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = scale * abs(zsph).^2.*cos(theta);

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

th = 0:pi/50:2*pi;
xunit = radius * cos(th);
yunit = radius * sin(th);
plot(xunit, yunit, 'k-', 'LineWidth', 1);
hold on;

axis off;
colormap(hsv);
clim([-pi pi]);
camlight left
camlight right
lighting phong
daspect([1 1 1]);
view(0, 40);
exportgraphics(gca, '../../gfx/ch-groundStateSymmetries/polar-HQV.pdf')