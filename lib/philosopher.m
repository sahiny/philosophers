function [time_elapsed, this_seed] = philosopher(varargin)
% Explain what it does
%% Handle Inputs
Paths = varargin{1};
prob_succ = varargin{2};
% make this a function
% assign defaults 
cycle_method = 'R2';
pre_load = false;
plot_stuff = false;
record_stuff = false;
max_time_threshold = 5*1e3;
arg_ind = 3;
while arg_ind <= nargin
    switch varargin{arg_ind}
        case 'cycle_method'
            cycle_method = varargin{arg_ind + 1};
            arg_ind = arg_ind + 2;
        case 'plot_stuff'
            plot_stuff = true;
            ws = varargin{arg_ind + 1};
            arg_ind = arg_ind + 2;
        case 'record_stuff'
            record_stuff = true;
            ws = varargin{arg_ind + 1};
            movie_name = varargin{arg_ind + 2};
            arg_ind = arg_ind + 3;
        case 'pre_load'
            pre_load = true;
            load(varargin{arg_ind + 1}); % replace with pre_load func
            deadlock_name = varargin{arg_ind + 1};
            arg_ind = arg_ind + 2;
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
    N = length( prob_succ);
    for i = 1:N
        Agents{i}.prob_succ = prob_succ(i);
    end
    %load(['Koenig_rand', num2str(random_number), '_', cycle_method]);
else
    % eval(['Koenig_random_', num2str(random_number)]);
    % Combine all these into one
    % Define agents, find drinking sessions
    N = length(Paths);
    Agents = cell(1,N);
    initial_locations = zeros(N,1);
    final_locations = zeros(N,1);

    for i = 1:N
        Agents{i} = agent(i,Paths, prob_succ(i));
        initial_locations(i) = Paths{i}(1);
        final_locations(i) = Paths{i}(end);
    end
    % create shared resources
    for i= 1:N
        Agents{i}.createBottlesSharedWith(Agents);
    end
    
    
    % find drinking sessions
    if strcmp(cycle_method, 'R2')
        findDrinkingSessionsR2(Agents, Paths);
    else
        for i= 1:N
            Agents{i}.findDrinkingSessions(cycle_method);
        end
    end
    set_initial_conditions(Agents);
end

%% Simulate
% visualizing
% if record_stuff is set, create a gif
if plot_stuff || record_stuff
    plot_ws(ws, initial_locations, final_locations, Paths)
    if record_stuff
        frame = getframe(2);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        imwrite(imind,cm,movie_name,'gif','DelayTime',0,'loopcount',inf);
    end
end

% simulate
this_seed = rng;
runs_completed = zeros(N,1);
time_elapsed = zeros(N,1);
positions = initial_locations;
while sum(runs_completed) < N
    random_order = randperm(N);
    for m = 1:N
        % agents try to move forward
%         n = m;
        n = random_order(m);
        if ~runs_completed(n)
            %%%%%%%%% DEBUG %%%%%%%%%%%%
            if n == 2 %&& Agents{2}.curr_pos_idx == 11
                1;
            end
            %%%%%%%%% DEBUG %%%%%%%%%%%%
            Agents{n}.move_philosopher();
            time_elapsed(n) = time_elapsed(n) + 1;
            if Agents{n}.curr_pos_idx == length(Agents{n}.path)
                runs_completed(n) = 1;
            end
        end
    end
    for n = 1:N
        positions(n) = Agents{n}.path(Agents{n}.curr_pos_idx);
    end

    if plot_stuff || record_stuff
        plot_ws(ws, positions, final_locations, []);
        if record_stuff % if plot_stuff is set, append to gif
            frame = getframe(2);
            im = frame2im(frame);
            [imind,cm] = rgb2ind(im,256);
            imwrite(imind,cm,movie_name,'gif','DelayTime',0.3,'writemode','append');
        end
    end
    
    % make this a function?
    if length(unique(positions)) < N
        [bincount, bin] = histc(positions, unique(positions));
        multiple = find(bincount > 1);
        colliding_agents = find(ismember(bin, multiple));
        disp(strcat('Collision between Agents ', num2str(colliding_agents'),'!'));
        save(['Crashing_seed_philosopher_A', num2str(colliding_agents'),'_t', num2str(max(time_elapsed))], 'varargin','this_seed');
        time_elapsed = -time_elapsed;
        break
        %pause
%         assert(1==0);
    end
   
    if max(time_elapsed) > max_time_threshold
        time_elapsed = -time_elapsed;
        disp(['Timed out! Simulation took more than ', num2str(max_time_threshold), ' steps']);
        save(['Deadlock_scenario_',deadlock_name], 'varargin', 'this_seed');
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
