function T = randTeams(nRobots, nTeams, minT, maxT)
% Returns random teams as a cell
T = cell(nTeams,1);
% number of robots in teams
nT = randi([minT maxT], nTeams-1, 1);
used = [];
for t = 1:nTeams-1
    P = randperm(nRobots);
    T{t} = sort(P(1:nT(t)));
    used = [used T{t}];
end
used = unique(used);
if isempty(setdiff(1:nRobots, used))
    P = randperm(nRobots);
    T{t+1} = sort(P(1:randi([minT, maxT], 1, 1)));
else
    nonused = setdiff(1:nRobots, used);
    i = 0;
    while i<length(nonused)
        n = randi([minT, maxT], 1, 1);
        T{t+1} = nonused(i+1:min(i+n, length(nonused)));
        i = i+n;
    end
end