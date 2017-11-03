function [totalTime, maxTime, totalDist, maxDist,finishTime, messages, nCollisions, succesfulCompletion, ...
    dummy_makespan, dummy_collisions, valids, heuristicValues] = Koenig(...
    nExample, maxSimNumber, rePlan_threshold)
    
% Sven Koenig Example
%ttotal = tic;
% bookkeeping
totalTime = zeros(maxSimNumber,rePlan_threshold);
maxTime = zeros(maxSimNumber,rePlan_threshold);
totalDist = zeros(maxSimNumber,rePlan_threshold);
maxDist = zeros(maxSimNumber,rePlan_threshold);
finishTimes = zeros(maxSimNumber,35);
messages = zeros(maxSimNumber,rePlan_threshold);
nCollisions = zeros(maxSimNumber,rePlan_threshold);
succesfulCompletion = zeros(maxSimNumber,rePlan_threshold);
dummy_makespan = zeros(maxSimNumber,rePlan_threshold);
dummy_collisions = zeros(maxSimNumber,rePlan_threshold);
valids = zeros(1,rePlan_threshold);
heuristicValues = [];

%% User Defined Parameters
% nExample = 2;
% Run the simulation maxSimNumber times
% maxSimNumber = 20;
% avoids initial locations if set to 1
initial_weight = 1000;
final_weight = 100000;
optimize_weight = 5;
session_threshold = 4;
% Stop replanning after this many times
% rePlan_threshold = 30;
% Simulation Horizon (end one run if not completed after 1000 step)
h = 1000;
% Maximum number of messages received for an agent
maxMessages = 2000;
% probality of sucessful move
% prob_succ = 1;
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
    case 11
        warehouse;
end
prob_succ =  prob_succ/2;
% save results to file
filename = strcat('trrr', num2str(nExample));
%% Generate Plans
% generate individual paths
%tpaths = tic;
%plot_ws(ws, initial_locations, final_locations, [])

badAgent = [];
oldbadAgent = [];
Plan = [];
currentBad = -2;
nextBad = -1;
iteration = 1;
while nextBad ~= currentBad
% for iteration = 1:rePlan_threshold
oldbadAgent = [oldbadAgent badAgent];    
currentBad = nextBad;
Plan = generate_Plan_Heuristic2(Plan, ws, initial_locations,...
    final_locations, oldbadAgent, badAgent, initial_weight, final_weight, optimize_weight);
%plot_ws(ws, initial_locations, final_locations, Plan.paths)
valid_plan = isvalid(Plan);

if ~valid_plan
    initial_weight = initial_weight*1000;
    final_weight = final_weight*1000;
end

longSessions = findLongSessions(Plan, session_threshold);

badAgent = longSessions.sessions(longSessions.maxBottleId).agentId;
nextBad = badAgent;

if ~isempty(longSessions)
%     badSessions = [badSessions,...
%         %longSessions.sessions(longSessions.longestSessionId),...
%         longSessions.sessions(longSessions.maxBottleId)
%         ];
end
% iteration = iteration +1;
heuristicValues = [heuristicValues; zeros(1,4)];
heuristicValues(iteration, 1) = longSessions.count*longSessions.avgBottle;
heuristicValues(iteration, 2) = longSessions.count*longSessions.avgLength;
heuristicValues(iteration, 3) = longSessions.avgLength*longSessions.avgBottle;
heuristicValues(iteration, 4) = longSessions.count*longSessions.avgBottle*longSessions.avgLength;

%tpaths = toc(tpaths)
%Plan = bestPlan;
valids(iteration) = valid_plan;
end
%% Simulation

for simNumber = 1:maxSimNumber
    % initialize agents
%     prob_succ = 0.5 + 0.5*rand(35,1);
    [agents, bottles, forks, Sessions] = generate_bottles_forks_sessions(ws, Plan.paths, Plan.conflicts);
    for n = 1:N
        %n
%          agents = [agents copy(Plan.agents(n))];
       agents(n).setPath(Plan.paths{n});
       agents(n).position = Plan.paths{n}(1);
       agents(n).conflict = Plan.conflicts{n};
       agents(n).bottles = bottles{n};
       agents(n).forks = forks{n};
       agents(n).sessions = Sessions{n};
       agents(n).localTime = 1;
       agents(n).globalTime = 0;
       agents(n).session_id = 1;
       agents(n).drinkingState = 'tranquil';
       agents(n).diningState = 'thinking';
       agents(n).maxGlobalTime = h+2;
       agents(n).maxMessages = maxMessages;
       agents(n).messageReceived = 0;
%        initial_locations(n) = agents(n).position;
    end
    
    % plot 
%     plot_ws(ws, initial_locations, final_locations, Plan.paths)
%     ttotal = toc(ttotal);

    %
    runs_completed = zeros(1,N);
    total_time = 0;
    total_distance = 0;
    max_distance = 0;
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
                    finishTime(simNumber, n) = agents(n).globalTime;
                    total_distance = total_distance + agents(n).localTime;
                    total_time = total_time + agents(n).globalTime;
                    if max_distance < agents(n).localTime
                        max_distance = agents(n).localTime;
                    end
                    %total_path_length = total_path_length + length(agents(n).path);
                end
            end
            %current_locations(n) = agents(n).position;
            positions(n) = agents(n).position;
        end
%         pause(0.01);
%         plot_ws(ws, positions, final_locations, Plan.paths)

        % check collisions
        if length(unique(positions))<N
            [bincount, bin] = histc(positions, unique(positions));
            multiple = find(bincount > 1);
            colliding_agents = find(ismember(bin, multiple));
            nCollisions(simNumber,iteration ) = nCollisions(simNumber, iteration) + 1;
        end

        % check dummy collisions
        if length(unique(dummy_positions))<N
            [bincount2, bin2] = histc(positions, unique(positions));
            multiple2 = find(bincount2 > 1);
            colliding_agents2    = find(ismember(bin2, multiple2));
            dummy_collisions(simNumber, iteration) = dummy_collisions(simNumber, iteration) + 1;
        end 
        
       if sum(runs_completed) == N
           succesfulCompletion(simNumber, 1) = 1;
           break;
       end
    end
    
    % bookkeeping
    total_messsages = 0;
    for n = 1:N
        total_messsages = total_messsages + agents(n).messageReceived;
    end
    if sum(runs_completed) < N
        disp('!!!Terminated before everyone finished!!!')
    end
    totalTime(simNumber, iteration) = total_time;
    totalDist(simNumber, iteration) = total_distance;
    maxTime(simNumber, iteration) = t;
    maxDist(simNumber, iteration) = max_distance;
    messages(simNumber, iteration) = total_messsages;
    dummy_makespan(simNumber, iteration) = dummy_totalTime/N;
    % save everytime
%     save(filename, 'makespan', 'makespan', 'messages', 'messages',...
%         'dummy_makespan', 'dummy_makespan', 'dummy_collisions', 'dummy_collisions',...
%         'nCollisions', 'nCollisions');
end
% save(filename);
% end