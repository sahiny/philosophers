clear;clc;close all;
% Simple example showing agents can follow each other
ttotal = tic;
%% User Defined Parameters
cycle_method = 'R2';
% Workspace
numRows = 15;
numCols = 15;
% individual paths
Paths = {[7 8:15:218 217]};
Paths{end+1} = [91 106:1:120 105];
Paths{end+1} = [9 8:15:218 219];
Paths{end+1} = [121 106:1:120 135];
% Number of robots
N = length(Paths);
% Obstacles
obstacles = [17:15:92 18:15:93 19:15:94 20:15:95 21:15:96 22:15:97 ...
    24:15:99 25:15:100 26:15:101 27:15:102 28:15:103 29:15:104 ...
    122:15:198 123:15:199 124:15:200 125:15:201 126:15:202 127:15:203 ...
    129:15:205 130:15:206 131:15:207 132:15:208 133:15:209 134:15:210];
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
%     set(gca,'xtick',[]);
%     set(gca,'ytick',[]);
%     ax = gca;
%     ax.Color = [1 1 1];
% %     pause(0.01)
%     drawnow;
%     frame = getframe(1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     outfile = 'example_cross.gif';
%     imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
% simulate
Agents = cell(1,N);
for i = 1:N
    Agents{i} = agent(i,Paths,1);
%     Agents{i}.Paths = Paths;
end

% create shared resources
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
time = 1;
% %%%%%% VIS PURPOSES %%%%%%
% global positions ws final_locations
% %%%%%% VIS PURPOSES %%%%%%
positions = initial_locations;
while sum(runs_completed) < N
    random_order = randperm(N);
    for m = 1:N
        % agents try to move forward
        %n = random_order(m);
        n=m;
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
%     plot_ws(ws, positions, final_locations, []);
%     drawnow;pause(0.01);
    plot_ws(ws, positions, final_locations, []);
%     set(gca,'xtick',[]);
%     set(gca,'ytick',[]);
%     ax = gca;
%     ax.Color = [1 1 1];
% %     pause(0.01)
%     drawnow;
%     frame = getframe(1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     imwrite(imind,cm,outfile,'gif','DelayTime',0.3,'writemode','append');

    if length(unique(positions)) < N
        disp(strcat('Collision between Agents ', num2str(colliding_agents),'!'));
   end
end

total_messsages = 0;
for n = 1:N
    total_messsages = total_messsages + Agents{n}.msgReceived;
end

max_time = max(time_elapsed)
avg_time = sum(time_elapsed)/N
1;
