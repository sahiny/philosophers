function bool = is_arrived(team, cp, pos)
bool = 1;
for n = 1:length(team.robots)
    robotID = team.robots(n);
    if norm(cp-pos(:, robotID),2)>1e-3
        bool = 0;
        return
    end
end