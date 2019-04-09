clear;clc;close all;
% Simple example showing agents can follow each other
ttotal = tic;
%% User Defined Parameters
cycle_method = 'R';
% Workspace size
numRows = 3;
numCols = 8;
% individual paths
Paths = {[7 8 11 14 17 16]};
Paths{end+1} = fliplr([5:3:20]);
% Paths{end+1} = [9 8:3:17 18];
% Number of robots
N = length(Paths);
% Obstacles
obstacles = [10 13 12 15];
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
    Agents{i} = agent(i,Paths, 1);
end

for i= 1:length(Paths)
    Agents{i}.createBottlesSharedWith(Agents);
end
for i= 1:length(Paths)
    Agents{i}.findDrinkingSessions(cycle_method);
end
runs_completed = zeros(1,N);
time_elapsed = zeros(1,N);
positions = initial_locations;
while sum(runs_completed) < N
    random_order = randperm(N);
    for m = 1:N
        % agents try to move forward
        n = m;random_order(m);
        if ~runs_completed(n)
            Agents{n}.move_philosopher();
            time_elapsed(n) = time_elapsed(n) + 1;
            if Agents{n}.curr_pos_idx == length(Agents{n}.path)
                runs_completed(n) = 1;
            end
%             positions(n) = Agents{n}.path(Agents{n}.curr_pos_idx);
%             plot_ws(ws, positions, final_locations, []);
%             drawnow;%pause(0.01);
        end
    end
    for n = 1:N
        positions(n) = Agents{n}.path(Agents{n}.curr_pos_idx);
    end
    plot_ws(ws, positions, final_locations, []);
    drawnow;%pause(0.01);

   if length(unique(positions)) < N
        disp(strcat('Collision between Agents ', num2str(colliding_agents),'!'));
   end
end

total_messsages = 0;
for n = 1:N
    total_messsages = total_messsages + Agents{n}.msgReceived;
end

max_time = max(time_elapsed)
avg_time = time_elapsed/N
total_messsages
1;
