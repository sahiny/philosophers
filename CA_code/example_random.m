clear;clc;
% Sven Koenig Example
ttotal = tic;
%% User Defined Parameters
% Number of robots
N = 35;
% Workspace
numRows = 30;
numCols = 30;
% fixed number of obstacles
numObs = round(numRows*numCols/10);
% Run the simulation maxSimNumber times
maxSimNumber = 1000;
% avoids initial locations if set to 1
avoid_initial = 1;
% Stop replanning after this many times
rePlan_threshold = 50;
% Simulation Horizon (end one run if not completed after 1000 step)
h = 1000;
% Maximum number of messages received for an agent
maxMessages = 2000;
% probality of sucessful move
prob_succ = 1;
%% Create workspace, agents, paths, etc
% Obstacles
obstacles = datasample(1:numRows*numCols, numObs, 'Replace', false);
% % obstacles = [2 5 8 14 17];
% % random Unique Initial and Final Locations
locations = setdiff(1:numRows*numCols, obstacles);
locations = datasample(locations, 2*N, 'Replace', false);
initial_locations = locations(1:N);
final_locations = locations(N+1:end);
% percentage of obstacles
%     pObs = 0.1;
%     obstacles = find(rand(numRows*numCols, 1) <= pObs);

ws = create_workspace(numRows, numCols, obstacles);


% initial_locations = [4 13 7];
% final_locations = [16 15 9];
plot_ws(ws, initial_locations, final_locations, [])


%% generate individual paths
%tpaths = tic;
valid_plan = 0;
mystack = planStack();
threshold = rePlan_threshold;
iteration = 1;
while ~valid_plan && iteration < rePlan_threshold
constraints = mystack.pop();
if iteration > 1 && isempty(constraints)
    assert(0==1,'Failed to find paths!');
end
Plan = generate_plan(ws, initial_locations, final_locations, constraints, avoid_initial);
plot_ws(ws, initial_locations, final_locations, Plan.paths)
[conflicting_agent_ids, initials] = find_initial_conflicts(Plan);
[valid_plan, options] = isvalid2(Plan);

if ~valid_plan
    
    for option = 1:length(options)
        new_constraints = [Plan.constraints; options(option,:)];
        mystack.push(constraints1, Plan.length);
    end
%     constraints1 = [Plan.constraints; option1]; 
%     constraints2 = [Plan.constraints; option2]; 
%     if ~isempty(constraints1)
%         mystack.push(constraints1, Plan.length);
%     end
%     if ~isempty(constraints2)
%         mystack.push(constraints2, Plan.length);
%     end
    iteration = iteration +1;
end
end
plot_ws(ws, initial_locations, final_locations, Plan.paths)
if valid_plan == 0
disp('Failed to find paths in given replanning threshold!');
end
%tpaths = toc(tpaths)
%% Simulation
% initialize agents
agents = Plan.agents;
for n = 1:N
   %agents = [agents agent(n)];
   agents(n).setPath(Plan.paths{n});
   agents(n).position = Plan.paths{n}(1);
   agents(n).conflict = Plan.conflicts{n};
   agents(n).bottles = Plan.bottles{n};
   agents(n).forks = Plan.forks{n};
   agents(n).sessions = Plan.Sessions{n};
   agents(n).localTime = 1;
   agents(n).globalTime = 0;
   agents(n).session_id = 1;
   agents(n).drinkingState = 'tranquil';
   agents(n).diningState = 'thinking';
   agents(n).maxGlobalTime = h+2;
   agents(n).maxMessages = maxMessages;
   agents(n).messageReceived = 0;
   initial_locations(n) = agents(n).position;
end
% plot 
plot_ws(ws, initial_locations, final_locations, Plan.paths)

[conflicting_agent_ids, initials] = find_initial_conflicts(Plan);



%ttotal = toc(ttotal);

% now simulate
runs_completed = zeros(1,N);
total_time = 0;
total_path_length = 0;
for t = 1:h
    positions = zeros(1,N);
    for n = 1:N
        % Move either moves or creates/finishes drinking session
        if ~runs_completed(n)
            bool = agents(n).move(1);
            if bool
                runs_completed(n) = 1;
                total_time = total_time + t -1;
                total_path_length = total_path_length + length(agents(n).path);
            end
        end
        % initial_locations(n) = agents(n).position;
        positions(n) = agents(n).position;
    end
    for n = 1:N
        positions(n) = agents(n).position;
    end
    pause(0.1);
    plot_ws(ws, positions, final_locations, Plan.paths)
   if sum(runs_completed) == N
       break;
   end
   if length(unique(positions))<N
        [bincount, bin] = histc(positions, unique(positions));
        multiple = find(bincount > 1);
        colliding_agents    = find(ismember(bin, multiple));
        assert(0==1, strcat('Collision between Agents ', num2str(colliding_agents),'!'));
   end
end

total_messsages = 0;
for n = 1:N
    total_messsages = total_messsages + agents(n).messageReceived;
end

max_time = t-1;
avg_time = total_time/N
avg_path_length = Plan.length/N
total_messsages
1;
