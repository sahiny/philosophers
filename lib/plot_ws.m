function plot_ws(ws, current_locations, final_locations, paths)
% visualization script
% 
% ws: workspace is a struct with the following fields
%   size: [numRows, numCols]
%   obstacles: vector containing the indices of inaccessible cells 
%              (example = [2, 3, ... ])
%              indices start from upleft corner and increase by one as you go down 
% 
% current_locations: vector with the indices of current locations of agents 
%                    (drawn as solid circles of different colors) 
% final_locations: vector with the indices of final locations of agents 
%                  (drawn as empty circles with the same color as cur_loc)
% paths: cell array of vectors with the indices of cells connecting cur_loc to fin_loc
%        (optional: can be left as [] if paths not to be drawn)

display_states = 0;

numAgents = max([length(current_locations), length(final_locations), length(paths)]);
numRows = ws.numRows;
numCols = ws.numCols;
obstacles = ws.obstacles;

% draw grid
figure(2);clf;hold on;
for i = 1:numRows
    rectangle('Position',[-0.5 i-1.5 numCols 1]);
%     text(numCols, numRows - i, num2str(i-1));
end
for i = 1:numCols
    rectangle('Position',[i-1.5 -0.5 1 numRows]);
%     text(i-1, numRows, num2str(i-1), 'Rotation', 90);
end

if display_states
    for i = 1:numCols
        for j = 1:numRows
            text(i-1.4, numRows-j-0.4, num2str((i-1)*numRows + j), 'FontSize', 5, 'HorizontalAlignment', 'center' );
            1;
        end
    end
end
% draw obstacles
    % convert to x-y
    [oy,ox] = ind2sub([numRows, numCols], obstacles);
    for i = 1:length(obstacles)
        rectangle('Position',[ox(i)-1.5 numRows-oy(i)-0.5 1 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    end

% draw initial/final locations
    % convert to x-y
    [iy, ix] = ind2sub([numRows, numCols], current_locations);
    iy = numRows - iy - 0.5;
    ix = ix - 1.5;
    [fy, fx] = ind2sub([numRows, numCols], final_locations);
    fy = numRows - fy - 0.5;
    fx = fx - 1.5;
    
    jet_colors = jet(numAgents+1);
    mycolors = zeros(numAgents,3);
    for c = 1:numAgents
        if mod(c,2) == 1
            mycolors(c,:) = jet_colors(ceil(c/2),:);
        else
            mycolors(c,:) = jet_colors(end-floor(c/2),:);
        end
    end
    
    for n = 1:numAgents
        rectangle('Position',[ix(n)+.1 iy(n)+.1 .8 .8], 'FaceColor', mycolors(n,:), 'Curvature', [1 1]);
        text(ix(n)+0.5, iy(n)+0.5, num2str(n), 'FontSize',8, 'Color', ones(1,3)-mycolors(n,:), 'HorizontalAlignment', 'center')
    end
    for n = 1:numAgents
        rectangle('Position',[fx(n)+.1 fy(n)+.1 .8 .8], 'EdgeColor', mycolors(n,:), 'Curvature', [1 1], 'LineWidth',2, 'LineStyle', '-');
    end
    
    if isempty(paths)
        1;
    else
        % draw paths
        for n = 1:length(paths)
            % convert to x-y
            if isempty(paths{n})
                continue
            end
            [py, px] = ind2sub([numRows, numCols], paths{n});
            py = numRows - py + n/(numAgents+1) - 0.5 ;
            px = px - n/(numAgents+1) - 0.5;
            px(1) = px(1) + n/(numAgents+1) - 0.5;
            px(end) = px(end) + n/(numAgents+1) - 0.5;
            py(1) = py(1) -  n/(numAgents+1) + 0.5;
            py(end) = py(end) -  n/(numAgents+1) + 0.5;
            plot(px, py, 'Color', mycolors(n,:), 'LineWidth',2);
            
            
            plot(px, py, 'Color', mycolors(n,:), 'LineWidth',2);
        end
    end
    

axis([-1 numCols+3 -1 numRows+3]);
axis equal
set(gca,'xtick',[]);
set(gca,'ytick',[]);
ax = gca;
ax.Color = [1 1 1];
drawnow;
