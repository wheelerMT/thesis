[x, y, z] = sphere(128);
h = surfl(x, y, z);
hold on
colormap('gray')
set(h, 'FaceAlpha', 0.05)
axis off
view(-45, 10)
shading interp
r = 0.86;
th = 0:pi/50:2*pi;
xunit = r * cos(th);
yunit = r * sin(th);
plot3(xunit, yunit, 0.5*ones(101), 'k:');
plot3(xunit, yunit, -0.5*ones(101), 'k:');

%% Points
plot3([0, 0], [0.86, -0.86], [-0.5, -0.5], 'ko', 'MarkerSize', 7.5, 'MarkerFaceColor', [0, 0.6, 0.8], ...
    'MarkerEdgeColor', 'none')
plot3([0.86, -0.86], [0, 0], [0.5, 0.5], 'ko', 'MarkerSize', 7.5, 'MarkerFaceColor', [0.9890 0.3940 0.1250], ...
    'MarkerEdgeColor', 'none')

%% Connecting lines
plot3([0, 0], [0.86, -0.86], [-0.5 -0.5], 'b');
plot3([0.86, -0.86], [0, 0], [0.5, 0.5], 'b');
plot3([0, 0.86], [0.86, 0], [-0.5, 0.5], 'b');
plot3([0, -0.86], [-0.86, 0], [-0.5, 0.5], 'b');
plot3([0, -0.86], [0.86, 0], [-0.5, 0.5], 'b');
plot3([0, 0.86], [-0.86, 0], [-0.5, 0.5], 'b');
exportgraphics(gca, '../../gfx/ch-groundStateSymmetries/C1-Majorana.pdf')