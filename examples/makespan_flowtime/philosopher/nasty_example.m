clear;clc;close all;
% Simple example showing agents can follow each other
ttotal = tic;
%% User Defined Parameters
cycle_method = 'R2';
% Workspace size
numRows = 10;
numCols = 10;
% individual paths
Paths = {[5:10:99]}; %1
% Paths{end+1} = 16:1:20; %2
% Paths{end+1} = 25:1:30; %2
% Paths{end+1} = 34:1:40; %2
% Paths{end+1} = 43:1:50; %2
% Paths{end+1} = 52:1:60; %2
% Paths{end+1} = 71:1:80; %2
% Paths{end+1} = 52:1:60; %
% Paths{end+1} = 91:-10:1; %3
% Paths{end+1} = 90:-1:81; %4

Paths{end+1} = 41:1:50; %2
Paths{end+1} = 98:-10:1; %2



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
plot_ws(ws, initial_locations, final_locations, [])

% simulate
Agents = cell(1,N);
for i = 1:N
    Agents{i} = agent(i,Paths, 1);
end

for i= 1:N
    Agents{i}.createBottlesSharedWith(Agents);
end
% find drinking sessions
if strcmp(cycle_method, 'R2')
    find_rainbow_cycles_all(Agents, Paths)
else
    for i= 1:N
        Agents{i}.findDrinkingSessions(cycle_method);
    end
end
set_initial_conditions(Agents);
runs_completed = zeros(1,N);
time_elapsed = zeros(1,N);
positions = initial_locations;
move_order = [1 9 8 7 6 5 4 3 2 1 9 9];

for i = move_order
   Agents{i}.move_philosopher();
    for n = 1:N
        positions(n) = Agents{n}.path(Agents{n}.curr_pos_idx);
    end
    plot_ws(ws, positions, final_locations, []);
    drawnow;%pause(0.01);

   if length(unique(positions)) < N
        disp(strcat('Collision between Agents ', num2str(colliding_agents),'!'));
   end
end

runs_completed = false(length(Agents),1);

for t = 1:50
for i = 1:length(Agents)
   Agents{i}.move_philosopher();
    for n = 1:N
        positions(n) = Agents{n}.path(Agents{n}.curr_pos_idx);
        runs_completed(n) = positions(n) == final_locations(n);
    end
    plot_ws(ws, positions, final_locations, []);
    drawnow;%pause(0.01);
   if length(unique(positions)) < N
        disp(strcat('Collision between Agents ', num2str(colliding_agents),'!'));
   end
end
if all(runs_completed)
    disp(['Done by step ', num2str(t)]);
    break
end
end