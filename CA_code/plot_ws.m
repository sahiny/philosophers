function plot_ws(ws, initial_locations, final_locations, paths)

N = length(initial_locations);
numRows = ws.numRows;
numCols = ws.numCols;
obstacles = ws.obstacles;

% draw grid
figure(1);clf;hold on;
axis([-1 numCols+1 -1 numRows+1]);
axis equal
for i = 1:numRows
    rectangle('Position',[0 i-1 numCols 1]);
end
for i = 1:numCols
    rectangle('Position',[i-1 0 1 numRows]);
end

% draw obstacles
    % convert to x-y
    [oy,ox] = ind2sub([numRows, numCols], obstacles);
    for i = 1:length(obstacles)
        rectangle('Position',[ox(i)-1 numRows-oy(i) 1 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    end

% draw initial/final locations
    % convert to x-y
    [iy, ix] = ind2sub([numRows, numCols], initial_locations);
    iy = numRows - iy;
    ix = ix - 1;
    [fy, fx] = ind2sub([numRows, numCols], final_locations);
    fy = numRows - fy;
    fx = fx - 1;
    
    mycolors = jet(N);
    for n = 1:N
        rectangle('Position',[ix(n)+.1 iy(n)+.1 .8 .8], 'FaceColor', mycolors(n,:), 'Curvature', [1 1]);
    end
    for n = 1:N
        rectangle('Position',[fx(n)+.1 fy(n)+.1 .8 .8], 'EdgeColor', mycolors(n,:), 'Curvature', [1 1], 'LineWidth',2, 'LineStyle', '-');
    end

    if isempty(paths)
        return
    end
% draw paths
for n = 1:N
    % convert to x-y
    [py, px] = ind2sub([numRows, numCols], paths{n});
    py = numRows - py + 0.5;
    px = px - 0.5;
    plot(px, py, 'Color', mycolors(n,:), 'LineWidth',2);
end
    