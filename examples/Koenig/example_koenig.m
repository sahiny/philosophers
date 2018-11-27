clear;clc;close all;
% koenig example
koenig_example_random1_parameters;
% individual paths
Koenig_paths_random1;
% Number of robots
N = length(Paths);
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
    set(gca,'ytick',[]);
    ax = gca;
    ax.Color = [1 1 1];
%     pause(0.01)
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'example_koenig.gif';
    imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
% simulate
Agents = cell(1,N);
for i = 1:N
    Agents{i} = agent(i,Paths{i});
    Agents{i}.Paths = Paths;
    Agents{i}.prob_succ = parameters(i, 5);
end

for i= 1:length(Paths)
    Agents{i}.createBottlesSharedWith(Agents);
end
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
        n = m;
        n = random_order(m);
        if ~runs_completed(n)
            Agents{n}.move();
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
%     drawnow;%pause(0.01);
    plot_ws(ws, positions, final_locations, []);
%     set(gca,'xtick',[]);
    set(gca,'ytick',[]);
    ax = gca;
    ax.Color = [1 1 1];
%     pause(0.01)
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,outfile,'gif','DelayTime',0.3,'writemode','append');

    if length(unique(positions)) < N
        [bincount, bin] = histc(positions, unique(positions));
        multiple = find(bincount > 1);
        colliding_agents = find(ismember(bin, multiple));
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
