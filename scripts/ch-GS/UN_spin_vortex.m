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

Y_2p2 = 0.25 * sqrt(15 / (2*pi)).* exp(2j * phi).* sin(theta).^2;
Y_2p1 = -0.5 * sqrt(15 / (2*pi)) * exp(1j * phi).* sin(theta).*cos(theta);
Y_2p0 = 0.25 * sqrt(5 / pi) * (3 * cos(theta).^2 - 1);
Y_2m1 = 0.5 * sqrt(15 / (2*pi)) * exp(-1j * phi).* sin(theta).*cos(theta);
Y_2m2 = 0.25 * sqrt(15 / (2*pi)).* exp(-2j * phi).* sin(theta).^2;

z_lim = 64;
scale = 3;

%% First ring
lower_x_lim = 60;
middle_x_lim = 64;
upper_x_lim = 68;
lower_y_lim = 60;
middle_y_lim = 64;
upper_y_lim = 68;
plot_angle = 0;
radius = 7;

zsph = zetaP2(lower_x_lim, lower_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(lower_x_lim, lower_y_lim, z_lim).* Y_2p1 ...
    + zeta0(lower_x_lim, lower_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(lower_x_lim, lower_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(lower_x_lim, lower_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;


zsph = zetaP2(lower_x_lim, middle_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(lower_x_lim, middle_y_lim, z_lim).* Y_2p1 ...
    + zeta0(lower_x_lim, middle_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(lower_x_lim, middle_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(lower_x_lim, middle_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(lower_x_lim, upper_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(lower_x_lim, upper_y_lim, z_lim).* Y_2p1 ...
    + zeta0(lower_x_lim, upper_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(lower_x_lim, upper_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(lower_x_lim, upper_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(middle_x_lim, upper_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(middle_x_lim, upper_y_lim, z_lim).* Y_2p1 ...
    + zeta0(middle_x_lim, upper_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(middle_x_lim, upper_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(middle_x_lim, upper_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(upper_x_lim, upper_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(upper_x_lim, upper_y_lim, z_lim).* Y_2p1 ...
    + zeta0(upper_x_lim, upper_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(upper_x_lim, upper_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(upper_x_lim, upper_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(upper_x_lim, middle_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(upper_x_lim, middle_y_lim, z_lim).* Y_2p1 ...
    + zeta0(upper_x_lim, middle_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(upper_x_lim, middle_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(upper_x_lim, middle_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(upper_x_lim, lower_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(upper_x_lim, lower_y_lim, z_lim).* Y_2p1 ...
    + zeta0(upper_x_lim, lower_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(upper_x_lim, lower_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(upper_x_lim, lower_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(middle_x_lim, lower_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(middle_y_lim, lower_y_lim, z_lim).* Y_2p1 ...
    + zeta0(middle_y_lim, lower_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(middle_y_lim, lower_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(middle_y_lim, lower_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

th = 0:pi/50:2*pi;
xunit = radius * cos(th);
yunit = radius * sin(th);
plot(xunit, yunit, 'k-', 'LineWidth', 1);
hold on;

%% Outer ring
lower_x_lim = 56;
middle_x_lim = 64;
upper_x_lim = 72;
lower_y_lim = 56;
middle_y_lim = 64;
upper_y_lim = 72;
plot_angle = 0;
radius = 14;

zsph = zetaP2(lower_x_lim, lower_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(lower_x_lim, lower_y_lim, z_lim).* Y_2p1 ...
    + zeta0(lower_x_lim, lower_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(lower_x_lim, lower_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(lower_x_lim, lower_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;


zsph = zetaP2(lower_x_lim, middle_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(lower_x_lim, middle_y_lim, z_lim).* Y_2p1 ...
    + zeta0(lower_x_lim, middle_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(lower_x_lim, middle_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(lower_x_lim, middle_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(lower_x_lim, upper_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(lower_x_lim, upper_y_lim, z_lim).* Y_2p1 ...
    + zeta0(lower_x_lim, upper_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(lower_x_lim, upper_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(lower_x_lim, upper_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(middle_x_lim, upper_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(middle_x_lim, upper_y_lim, z_lim).* Y_2p1 ...
    + zeta0(middle_x_lim, upper_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(middle_x_lim, upper_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(middle_x_lim, upper_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(upper_x_lim, upper_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(upper_x_lim, upper_y_lim, z_lim).* Y_2p1 ...
    + zeta0(upper_x_lim, upper_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(upper_x_lim, upper_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(upper_x_lim, upper_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(upper_x_lim, middle_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(upper_x_lim, middle_y_lim, z_lim).* Y_2p1 ...
    + zeta0(upper_x_lim, middle_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(upper_x_lim, middle_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(upper_x_lim, middle_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(upper_x_lim, lower_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(upper_x_lim, lower_y_lim, z_lim).* Y_2p1 ...
    + zeta0(upper_x_lim, lower_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(upper_x_lim, lower_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(upper_x_lim, lower_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

h = surf(xx,yy,zz,angle(zsph));
set(h, 'LineStyle','none')
hold on;

zsph = zetaP2(middle_x_lim, lower_y_lim, z_lim).* Y_2p2 ...
    + zetaP1(middle_y_lim, lower_y_lim, z_lim).* Y_2p1 ...
    + zeta0(middle_y_lim, lower_y_lim, z_lim).* Y_2p0 ...
    + zetaM1(middle_y_lim, lower_y_lim, z_lim).* Y_2m1 ...
    + zetaM2(middle_y_lim, lower_y_lim, z_lim).* Y_2m2;
zsph = zsph * scale;
xx = abs(zsph).^2.*sin(theta).*cos(phi) ...
    + radius * cos(plot_angle);
yy = abs(zsph).^2.*sin(theta).*sin(phi) ...
    + radius * sin(plot_angle);
zz = abs(zsph).^2.*cos(theta);
plot_angle = plot_angle + 2 * pi / 8;

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
view(-23, 30);
exportgraphics(gca, '../../../gfx/ch-spin2/BN_DQV.pdf')