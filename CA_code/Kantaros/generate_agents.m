function teams = generate_agents(T,ws)
% create philosophers from team members
% distribute forks and bottles
nTeams = length(T);
teams = [];
for t = 1:nTeams
   teams = [teams; agent(t)];
   teams(t).addRobots(T{t});
   teams(t).ComPts = ws.C{t};
end
fork_counter = 1;
bottle_counter = 1;
for n = 1:nTeams-1
    for m = n+1:nTeams
        I = intersect(T{n},T{m});
        if ~isempty(I)
            % create a fork for n
            f = fork(fork_counter, teams(m), 1, 0, 1);
            teams(n).addForks(f);
            % create a fork for m
            f = fork(fork_counter, teams(n), 0, 1, 0);
            teams(m).addForks(f);
            % update counter
            fork_counter = fork_counter+1;
            % create bottles
            for i = 1:length(I)
                % common agent
                ii = I(i); 
                % bottle_n
                % obj = bottle(id, sharedWith, holding, req, need, occupy)
                b = bottle(bottle_counter, teams(m), 1, 0, 0, 0);
                teams(n).addBottles(b);
                % bottle_m
                b = bottle(bottle_counter, teams(n), 0, 1, 0, 0);
                teams(m).addBottles(b);
                bottle_counter = bottle_counter + 1;
            end
        end
    end
end