clear;clc;close all;
% Simple example showing agents can follow each other
ttotal = tic;
%% User Defined Parameters
% Workspace size
numRows = 7;
numCols = 8;
% individual paths
Paths = {[3 10 17 24 31 32 33 26 19 12 7]}; %1
Paths{end+1} = [9 10 17 24 31 32 33 26 19 12 14]; %2
Paths{end+1} = [23 24 31 32 33 26 19 12 21]; %3
Paths{end+1} = [30 31 32 33 26 19 12 28]; %4
Paths{end+1} = [39 32 33 26 19 12 35]; %5
Paths{end+1} = [40 33 26 19 12 42]; %6
Paths{end+1} = [27 26 19 12 49]; %7
Paths{end+1} = [20 19 18 17 16 15 22]; %8
Paths{end+1} = [8 15 16 17 18 11]; %9

% Number of robots
N = length(Paths);
% Obstacles
obstacles = [];
% Unique Initial and Final Locations
initial_locations = zeros(1,N);
final_locations = zeros(1,N);
for i = 1:N
    initial_locations(i) = Paths{i}(1);
    final_locations(i) = Paths{i}(end);
end

% visualize
ws = create_workspace(numRows, numCols, obstacles);
plot_ws(ws, initial_locations, final_locations, Paths)

% simulate
Agents = cell(1,N);
for i = 1:N
    Agents{i} = agent(i,Paths{i});
    Agents{i}.Paths = Paths;
end

for i= 1:length(Paths)
    Agents{i}.createBottlesSharedWith(Agents);
end
runs_completed = zeros(1,N);
time_elapsed = zeros(1,N);
positions = initial_locations;
move_order = [1 1 2 3 4 5 6 7 8 9 9];

for i = move_order
   Agents{i}.move();
    for n = 1:N
        positions(n) = Agents{n}.path(Agents{n}.curr_pos_idx);
    end
    plot_ws(ws, positions, final_locations, []);
    drawnow;%pause(0.01);

   if length(unique(positions)) < N
        disp(strcat('Collision between Agents ', num2str(colliding_agents),'!'));
   end
end
