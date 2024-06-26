% Create the wave function
% Create the spherical harmonics
% Map and plot spherical harmonics to circle

nx = 128;
ny = 128;
nz = 128;
dx = 20 / nx;
dy = 20 / ny;
dz = 20 / nz;

x = (-nx/2:nx/2-1) * dx;
y = (-ny/2:ny/2-1) * dy;
z = (-nz/2:nz/2-1) * dz;
[X, Y, Z] = meshgrid(x, y, z);

file = '../../../../thesis_data/5f_C-FM=2_coreless.hdf5';
frame = 2;
psiP2 = squeeze(h5read(file, '/wavefunction/psiP2').r(frame, :, :, :) ...
    + 1j * h5read(file, '/wavefunction/psiP2').i(frame, :, :, :));
psiP1 = squeeze(h5read(file, '/wavefunction/psiP1').r(frame, :, :, :) ...
    + 1j * h5read(file, '/wavefunction/psiP1').i(frame, :, :, :));
psi0 = squeeze(h5read(file, '/wavefunction/psi0').r(frame, :, :, :) ...
    + 1j * h5read(file, '/wavefunction/psi0').i(frame, :, :, :));
psiM1 = squeeze(h5read(file, '/wavefunction/psiM1').r(frame, :, :, :) ...
    + 1j * h5read(file, '/wavefunction/psiM1').i(frame, :, :, :));
psiM2 = squeeze(h5read(file, '/wavefunction/psiM2').r(frame, :, :, :) ...
    + 1j * h5read(file, '/wavefunction/psiM2').i(frame, :, :, :));

psiP2 = permute(psiP2, [3 2 1]);
psiP1 = permute(psiP1, [3 2 1]);
psi0 = permute(psi0, [3 2 1]);
psiM1 = permute(psiM1, [3 2 1]);
psiM2 = permute(psiM2, [3 2 1]);

n = abs(psiP2).^2 + abs(psiP1).^2 + abs(psi0).^2 + abs(psiM1).^2 ...
    + abs(psiM2).^2;
zetaP2 = psiP2./ sqrt(n);
zetaP1 = psiP1./ sqrt(n);
zeta0 = psi0./ sqrt(n);
zetaM1 = psiM1./ sqrt(n);
zetaM2 = psiM2./ sqrt(n);

% fx = conj(psiM2).* psiM1 ...
%     + conj(psiM1).* (sqrt(3/2).* psi0 + psiM2) ...
%     + conj(psi0).* sqrt(3/2).* (psiP1 + psiM1) ...
%     + conj(psiP1).* (psiP2 + sqrt(3/2).* psi0) ...
%     + conj(psiP2).* psiP1;
% fy = 1j * (conj(psiM2).* psiM1 ...
%     + conj(psiM1).* (sqrt(3/2).* psi0 - psiM2) ...
%     + conj(psi0).* sqrt(3/2).* (psiP1 - psiM1) ...
%     + conj(psiP1).* (psiP2 - sqrt(3/2).* psi0) ...
%     - conj(psiP2).* psiP1);
% fz = 2 * (abs(psiP2).^2 - abs(psiM2).^2) + abs(psiP1).^2 - abs(psiM1).^2;
% 
% spin_mag = sqrt(abs(fx).^2 + abs(fy).^2 + abs(fz).^2)./ n;
% spin_mag(n < 1e-6) = 0;
% plot = pcolor(spin_mag(:, :, 64));
% colormap('jet');
% plot.FaceColor = 'interp';
% plot.EdgeColor = 'None';
% clim([0, 2]);
% colorbar;


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

z_lim = 84;
scale = 0.9;

%% Outer ring
lower_x_lim = 68;
middle_x_lim = 74;
upper_x_lim = 80;
lower_y_lim = 68;
middle_y_lim = 74;
upper_y_lim = 80;
plot_angle = pi;
radius = 14;

for ii = lower_x_lim :2: upper_x_lim
    for jj = lower_y_lim :2: upper_y_lim
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
view(0, 35);
colormap(hsv);
clim([-pi pi]);
camlight left
camlight right
lighting phong
daspect([1 1 1]);

% exportgraphics(gca, '../../../gfx/ch-spin2/C-FM=2_coreless_FM_after_spherical.pdf')