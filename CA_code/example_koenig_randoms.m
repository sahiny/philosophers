clear;clc;
% Sven Koenig Example
ttotal = tic;

%% User Defined Parameters
% What example
nExample = 1;
% Run the simulation maxSimNumber times
maxSimNumber = 1;
% Stop replanning after this many times
rePlan_threshold = 10;
% Simulation Horizon (end one run if not completed after 1000 step)
h = 1000;
% Maximum number of messages received for an agent
maxMessages = 2000;
%maxGlobalTime = h;
%% Random Examples
switch nExample
    case 1
        koenig_example_random1_parameters;
    case 2
        koenig_example_random2_parameters;
    case 3
        koenig_example_random3_parameters;
    case 4
        koenig_example_random4_parameters;
    case 5
        koenig_example_random5_parameters;
    case 6
        koenig_example_random6_parameters;
    case 7
        koenig_example_random7_parameters;
    case 8
        koenig_example_random8_parameters;
    case 9
        koenig_example_random9_parameters;
    case 10
        koenig_example_random10_parameters;
end
% save results to file
filename = strcat('results_random', num2str(nExample));
%% Generate Plans
% generate individual paths
%tpaths = tic;
plot_ws(ws, initial_locations, final_locations, [])

valid_plan = 0;
mystack = planStack();
iteration = 1;
while ~valid_plan && iteration < rePlan_threshold
constraints = mystack.pop();
if iteration > 1 & isempty(constraints)
    assert('Failed to find paths!');
end
Plan = generate_plan(ws, initial_locations, final_locations, constraints, 1);
plot_ws(ws, initial_locations, final_locations, Plan.paths)

[valid_plan, option1, option2] = isvalid(Plan);
if ~valid_plan
    constraints1 = [Plan.constraints; option1]; 
    constraints2 = [Plan.constraints; option2]; 
    if ~isempty(constraints1)
        mystack.push(constraints1, Plan.length);
    end
    if ~isempty(constraints2)
        mystack.push(constraints2, Plan.length);
    end
    iteration = iteration +1;
end
end
%tpaths = toc(tpaths)

%% Simulation
% bookkeeping
makespan = zeros(maxSimNumber,1);
messages = zeros(maxSimNumber,1);
nCollisions = zeros(maxSimNumber,1);
dummy_makespan = zeros(maxSimNumber,1);
dummy_collisions = zeros(maxSimNumber,1);

for simNumber = 1:maxSimNumber
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
       %initial_locations(n) = agents(n).position;
    end
    
    % plot 
    %plot_ws(ws, initial_locations, final_locations, Plan.paths)
    %ttotal = toc(ttotal);

    %
    runs_completed = zeros(1,N);
    total_time = 0;
    positions = 1:N;
    total_path_length = 0;
    dummy_runs_completed = zeros(1,N);
    dummy_localTime = ones(1,N);
    dummy_totalTime = 0;
    dummy_positions = zeros(1,N);
    
    for i = 1:N
        dummy_positions(n) = Plan.paths{n}(1);
    end

    for t = 1:h
        
        for n = 1:N

           % dummy sim
           if ~dummy_runs_completed(n)
               if rand(1) < prob_succ(n)
                   dummy_localTime(n) = dummy_localTime(n)+1;
                   dummy_positions(n) = Plan.paths{n}(dummy_localTime(n));
               end
              if dummy_localTime(n) == length(Plan.paths{n})
                dummy_runs_completed(n) = 1;
                dummy_totalTime = dummy_totalTime + t;
              end
           end

            % Move either moves or creates/finishes drinking session
            if ~runs_completed(n)
                bool = agents(n).move(prob_succ(n));
                if bool
                    runs_completed(n) = 1;
                    total_time = total_time + agents(n).globalTime;
                    %total_path_length = total_path_length + length(agents(n).path);
                end
            end
            %current_locations(n) = agents(n).position;
            positions(n) = agents(n).position;
            
            
            % check collisions
            if length(unique(positions))<N
                [bincount, bin] = histc(positions, unique(positions));
                multiple = find(bincount > 1);
                colliding_agents    = find(ismember(bin, multiple));
                nCollisions(simNumber) = nCollisions(simNumber) + 1;
            end

            % check dummy collisions
            if length(unique(dummy_positions))<N
                [bincount2, bin2] = histc(positions, unique(positions));
                multiple2 = find(bincount2 > 1);
                colliding_agents2    = find(ismember(bin2, multiple2));
                dummy_collisions(simNumber) = dummy_collisions(simNumber) + 1;
            end
            
        end
        %pause(0.03);
        %plot_ws(ws, positions, final_locations, Plan.paths)

       if sum(runs_completed) == N
           break;
       end
    end
    
    
    % bookkeeping
    total_messsages = 0;
    for n = 1:N
        total_messsages = total_messsages + agents(n).messageReceived;
    end

    makespan(simNumber) = total_time/N;
    messages(simNumber) = total_messsages;
    dummy_makespan(simNumber) = dummy_totalTime/N;
    % save everytime
    save(filename, 'makespan', 'makespan', 'messages', 'messages',...
        'dummy_makespan', 'dummy_makespan', 'dummy_collisions', 'dummy_collisions',...
        'nCollisions', 'nCollisions');
end