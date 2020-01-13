function [time_elapsed, num_messages] = mcp(varargin)
% Given a collection of paths, 
% simulates agents using AME method of Ma et.al

%% Handle Inputs
Paths = varargin{1};
prob_succ = varargin{2};
% assign defaults
plot_stuff = false;
record_stuff = false;
max_time_threshold = 5000;
arg_ind = 3;
while arg_ind <= nargin
    switch varargin{arg_ind}
        case 'plot_stuff'
            plot_stuff = true;
            ws = varargin{arg_ind + 1};
            arg_ind = arg_ind + 2;
        case 'record_stuff'
            record_stuff = true;
            ws = varargin{arg_ind + 1};
            movie_name = varargin{arg_ind + 2};
            arg_ind = arg_ind + 3;
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

%% Define Agents

N = length(Paths);
positions = zeros(N,1);
Agents = cell(1,N);
for i = 1:N
    Agents{i} = agent(i,Paths, prob_succ(i));
    initial_locations(i) = Paths{i}(1);
    final_locations(i) = Paths{i}(end);
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
runs_completed = zeros(1,N);
t = 1;
while sum(runs_completed) < N
    % choose a random oder for the agents
    random_order = randperm(N);
    for m = 1:N
        % agents try to move forward if not already completed their runs
        n = m;  %n = random_order(m);
        if ~runs_completed(n)
            Agents{n}.move_mcp(Agents);
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
        if record_stuff
            frame = getframe(2);
            im = frame2im(frame);
            [imind,cm] = rgb2ind(im,256);
            imwrite(imind,cm,movie_name,'gif','DelayTime',0,'loopcount',inf);
        end
    end

   if length(unique(positions)) < N
        [bincount, bin] = histc(positions, unique(positions));
        multiple = find(bincount > 1);
        colliding_agents = find(ismember(bin, multiple));
        disp(strcat('Collision between Agents ', num2str(colliding_agents'),'!'));
        save(['Crashing_seed_mcp_A', num2str(colliding_agents'),'_t', num2str(t)], 'varargin','this_seed');
        time_elapsed = zeros(N,1);
        num_messages = zeros(N,1);
        for n = 1:N
            time_elapsed(n) = -Agents{n}.time_elapsed;
            num_messages(n) = -Agents{n}.msgReceived;
        end
        return
%         assert(1==0)
   end
   
   
   t = t + 1;
   %%%%%%%% DEBUG %%%%%%%%
   if t == 31
       1;
   end
   
end

%% Assign outputs
time_elapsed = zeros(N,1);
num_messages = zeros(N,1);
for n = 1:N
    time_elapsed(n) = Agents{n}.time_elapsed;
    num_messages(n) = Agents{n}.msgReceived;
end

max_time = max(time_elapsed)
avg_time = time_elapsed/N;
1;


