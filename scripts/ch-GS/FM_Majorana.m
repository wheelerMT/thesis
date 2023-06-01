[x, y, z] = sphere(128);
h = surfl(x, y, z);
hold on
colormap('gray')
set(h, 'FaceAlpha', 0.05)
axis off
shading interp
r = 1;
th = 0:pi/50:2*pi;
xunit = r * cos(th);
yunit = r * sin(th);
h = plot(xunit, yunit, 'k:');
plot([-1, 1], [0, 0], 'k:');
plot([0, 0], [-1, 1], 'k:');
plot3([0, 0], [0, 0], [-1, 1], 'k:');
plot3(0, 0, 1, 'ko', 'MarkerSize', 15, 'MarkerFaceColor', 'red', ...
    'MarkerEdgeColor', 'none');
exportgraphics(gca, '../../gfx/ch-groundStateSymmetries/FM-Majorana.pdf')