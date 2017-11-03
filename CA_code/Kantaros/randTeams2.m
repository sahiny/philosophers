function T = randTeams2(nRobots, minT, maxT)
% Returns random teams as a cell
T = {};
% number of robots in teams
used = [];
nonused = 1:nRobots;
t = 1;
while ~isempty(nonused)
    n = randi([minT, maxT], 1, 1);
    r = randperm(nRobots);
    r = r(1:n);
    used = unique([used r]);
    nonused = setdiff(1:nRobots, used);
    T{t} = r;
    t = t+1;
end

A = zeros(length(T));
for n = 1:length(T) - 1
    for m = n+1:length(T)
        if ~isempty(intersect(T{n}, T{m}))
            A(n,m) = 1;
            A(m,n) = 1;
        end
    end
end
G = graph(A);

bins = conncomp(G);
while length(unique(bins)) > 1
    n = randi([minT, maxT], 1, 1);
    r = randperm(nRobots);
    r = r(1:n);
    T{t} = r;
    t = t+1;
    A = zeros(length(T));
    for n = 1:length(T) - 1
        for m = n+1:length(T)
            if ~isempty(intersect(T{n}, T{m}))
                A(n,m) = 1;
                A(m,n) = 1;
            end
        end
    end
    G = graph(A);

    bins = conncomp(G);
end