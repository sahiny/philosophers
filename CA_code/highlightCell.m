function highlightCell(cellId,ws, initial_locations, final_locations, paths)
plot_ws(ws, positions, final_locations, paths)
figure(1)
hold on
[cy, cx] = ind2sub([numRows, numCols], initial_locations);
rectangle('Position',[cx(n)+.1 cy(n)+.1 1 1], 'EdgeColor', 'r', 'Curvature', [1 1]);
pause(0.1);
hold off
plot_ws(ws, positions, final_locations, paths)
figure(1)
hold off

hold on
rectangle('Position',[cx(n)+.1 cy(n)+.1 1 1], 'EdgeColor', 'r', 'Curvature', [1 1]);
pause(0.1);
hold off

figure(1)
hold on
plot_ws(ws, positions, final_locations, paths)
hold off
