function Plan = generate_Plan_Heuristic(ws, initial_locations,...
    final_locations, badSessions, initial_weight, final_weight,optimize_weight)

% number of robots
N = length(initial_locations);
% mycolors = jet(N);
% store paths
paths = cell(1,N);
% total distance
tdistance = 0;
% shortest total distance
sdistance = 0;

% plot_ws(ws, initial_locations, final_locations, []);

for n = 1:N
    % transition graph
    adjr_n = ws.adjr;
    % penalize transitions into initial locations
    adjr_n(:,ws.n2r(initial_locations)) = initial_weight*adjr_n(:,ws.n2r(initial_locations));
    
    % penalize transitions into final locations
    adjr_n(:, ws.n2r(final_locations)) = final_weight*adjr_n(:, ws.n2r(final_locations));

    % penalize passes from/into constraints
    weighted_adjr_n = adjr_n;
    if ~isempty(badSessions)
        for i = 1:length(badSessions)
            badSession = badSessions(i);
            if badSession.agentId == n
                for m = 1:badSession.length
                    weighted_adjr_n(:, ws.n2r(badSession.ascCells(m))) =...
                        weighted_adjr_n(:, ws.n2r(badSession.ascCells(m))) +...
                        optimize_weight*badSession.ascBottleNumber(m)*m*adjr_n(:, ws.n2r(badSession.ascCells(m)));
                end
            end
        end
    end
    % find the shortest path
    Gn = digraph(weighted_adjr_n);
    s = ws.n2r(initial_locations(n));
    t = ws.n2r(final_locations(n));
    [path_n, dn] = shortestpath(Gn, s, t);
    assert(dn>0, strcat('No paths exists for Agent', num2str(n)));
    assert(~isempty(path_n), strcat('No paths exists for Agent', num2str(n)));
    path_n = ws.r2n(path_n);
    paths{n} = path_n;
    
    
%     figure(1);hold on
%     [py, px] = ind2sub([ws.numRows, ws.numCols], paths{n});
%     py = ws.numRows - py + 0.5;
%     px = px - 0.5;
%     plot(px, py, 'Color', mycolors(n,:), 'LineWidth',2);
%     
    
    % compute extra the distance
    Gn = graph(ws.adjr);
    s = ws.n2r(initial_locations(n));
    t = ws.n2r(final_locations(n));
    [path_s,ds] = shortestpath(Gn, s, t);
    
    tdistance = tdistance + dn;
    sdistance = sdistance + ds;
end

% disp(['total number of steps: ', num2str(tdistance) ])
% disp(['total number of steps (shortest): ', num2str(sdistance) ])
% disp(['extra steps required: ', num2str(tdistance - sdistance) ])


conflicts = find_conflicts(paths);
[agents, bottles, forks, Sessions] = generate_bottles_forks_sessions(ws, paths, conflicts);

Plan = struct();
Plan.paths = paths;
Plan.conflicts = conflicts;
Plan.bottles = bottles;
Plan.forks = forks;
Plan.Sessions = Sessions;
Plan.badSession = badSessions;
Plan.length = tdistance;
Plan.agents = agents;
for n = 1:N
    Plan.agents(n).path = paths{n};
    Plan. agents(n).position = Plan.paths{n}(1);
    Plan.agents(n).conflict = conflicts{n};
    Plan.agents(n).bottles = bottles{n};
    Plan.agents(n).forks = forks{n};
    Plan.agents(n).sessions = Sessions{n};
    Plan.agents(n).localTime = 1;
    Plan.agents(n).globalTime = 0;
    Plan.agents(n).session_id = 1;
    Plan.agents(n).drinkingState = 'tranquil';
    Plan.agents(n).diningState = 'thinking';
    Plan.agents(n).maxGlobalTime = 1000;
    Plan.agents(n).maxMessages = 2000;
    Plan.agents(n).messageReceived = 0;
end
%PlanNode.isvalid = isvalid(PlanNode);