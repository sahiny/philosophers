function [time_elapsed, this_seed] = example_results_Koenig(varargin)
%% User defined variables
% environment number
% random_number = 1;
random_number = varargin{1};
% assign defaults
cycle_method = 'SR';
pre_load = false;
plot_stuff = false;
record_stuff = false;
max_time_threshold = 1000;
arg_ind = 2;
while arg_ind <= nargin
    switch varargin{arg_ind}
        case 'cycle_method'
            cycle_method = varargin{arg_ind+1};
            arg_ind = arg_ind + 2;
        case 'plot_stuff'
            plot_stuff = true;
            arg_ind = arg_ind + 1;
        case 'record_stuff'
            record_stuff = true;
            arg_ind = arg_ind + 1;
        case 'pre_load'
            pre_load = true;
            arg_ind = arg_ind + 1;
        case 'max_time_threshold'
            max_time_threshold = varargin{arg_ind+1};
            arg_ind = arg_ind + 2;  
        case 'fix_seed'
            rng(varargin{arg_ind+1});
            arg_ind = arg_ind + 2; 
        otherwise
            error(['Unrecognized string input: ' varargin{arg_ind} ])
    end
end

% load pre_computed drinking sessions if flag is set
if pre_load
    load(['Koenig_rand', num2str(random_number), '_', cycle_method]);
else
    eval(['Koenig_random_', num2str(random_number)]);
end
% plot the environment and agents if flag is set
if plot_stuff || record_stuff
    plot_ws(ws, initial_locations, final_locations, Paths)
end


% if record_stuff is set, create a gif
if record_stuff
    frame = getframe(2);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = ['movie_Koenig_rand', num2str(random_number), '_', cycle_method,'.gif'];
    imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
end
if ~pre_load
% Define agents, find drinking sessions
Agents = cell(1,N);
for i = 1:N
    Agents{i} = agent(i,Paths{i}, parameters(i, 5));
    Agents{i}.Paths = Paths;
%     Agents{i}.prob_succ = ;
end
% create shared resources
for i= 1:length(Paths)
    Agents{i}.createBottlesSharedWith(Agents);
end
% find drinking sessions
for i= 1:length(Paths)
    Agents{i}.findDrinkingSessions(cycle_method);
end
set_initial_conditions(Agents)
end

%% Simulate
this_seed = rng;
% rng(this_seed) % comment this in to fix the seed 
if plot_stuff || record_stuff
    plot_ws(ws, initial_locations, final_locations, Paths)
end
runs_completed = zeros(1,N);
time_elapsed = zeros(1,N);
positions = initial_locations;
while sum(runs_completed) < N
    random_order = randperm(N);
    for m = 1:N
        % agents try to move forward
%         n = m;
        n = random_order(m);
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
    if positions(7) == 443
        1;
    end
    if plot_stuff || record_stuff
        plot_ws(ws, positions, final_locations, []);
    end
    
    if record_stuff % if plot_stuff is set, append to gif
        frame = getframe(2);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,outfile,'gif','DelayTime',0.3,'writemode','append');
    end
    
    if length(unique(positions)) < N
        [bincount, bin] = histc(positions, unique(positions));
        multiple = find(bincount > 1);
        colliding_agents = find(ismember(bin, multiple));
        disp(strcat('Collision between Agents ', num2str(colliding_agents),'!'));
        str_crash = ['Crashing_seed_random', num2str(random_number)];
        str_crash = [str_crash,'_A', num2str(colliding_agents(1)),'_A', num2str(colliding_agents(2))];
        str_crash = [str_crash,'_t', num2str(max(time_elapsed))];
        save(str_crash, 'this_seed');
        assert(1==0)
    end
   
    if max(time_elapsed) > max_time_threshold
        time_elapsed = -time_elapsed;
        disp(['Timed out! Simulation took more than ', num2str(max_time_threshold), ' steps'])
        break
    end
    
end

% total_messsages = 0;
% for n = 1:N
%     total_messsages = total_messsages + Agents{n}.msgReceived;
% end
if max(time_elapsed) > 0
    disp(['max_time = ', num2str(max(time_elapsed))]);
end
% avg_time = sum(time_elapsed)/N
1;
