function Plan = generate_plan_longestSessionHeuristic(ws, initial_locations,...
    final_locations, constraints, avoid_initial)

if avoid_initial
    final_locations = [final_locations initial_locations];
end

% 
N = length(initial_locations);

paths = cell(1,N);
adjr_n = ws.adjr;
tdistance = 0;
sdistance = 0;
for n = 1:N
    adjr_n = ws.adjr;
    final_locations_n = ws.n2r(...
        setdiff(final_locations, [final_locations(n) initial_locations(n)]));
    % set final locations as obstacles
    adjr_n(final_locations_n, :) = 0;
    adjr_n(:, final_locations_n) = 0;
    % set constraints as obstacles
    if ~isempty(constraints)
        constraints_n = find(constraints(:,1) == n);
        if ~isempty(constraints_n)
            constraints_r = ws.n2r(constraints(constraints_n,2));
            adjr_n(constraints_r, :) = 0;
            adjr_n(:, constraints_r) = 0;    
        end
    end
    % find the shortest path
    Gn = graph(adjr_n);
    s = ws.n2r(initial_locations(n));
    t = ws.n2r(final_locations(n));
    [path_n, dn] = shortestpath(Gn, s, t);
    assert(dn>0, strcat('No paths exists for Agent', num2str(n)));
    assert(~isempty(path_n), strcat('No paths exists for Agent', num2str(n)));
    path_n = ws.r2n(path_n);
    paths{n} = path_n;
    
    % compute extra the distance
    Gn = graph(ws.adjr);
    s = ws.n2r(initial_locations(n));
    t = ws.n2r(final_locations(n));
    [path_s,ds] = shortestpath(Gn, s, t);
    
    tdistance = tdistance + dn;
    sdistance = sdistance + ds;
end

conflicts = find_conflicts(paths);
[agents, bottles, forks, Sessions] = generate_bottles_forks_sessions(ws, paths, conflicts);


Plan = struct();
Plan.paths = paths;
Plan.conflicts = conflicts;
Plan.bottles = bottles;
Plan.forks = forks;
Plan.Sessions = Sessions;
Plan.constraints = constraints;
Plan.length = tdistance;
Plan.agents = agents;
%PlanNode.isvalid = isvalid(PlanNode);