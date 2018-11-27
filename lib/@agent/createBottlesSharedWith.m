function createBottlesSharedWith(obj, Agents)
% creates a bottle for each state sharedWith Agents
for a = 1:length(Agents)
    agent2 = Agents{a};
    if agent2.id == obj.id
        continue
    end
    [~, ia, ~] = intersect(obj.path, agent2.path);
    for iap = ia'
        obj.createBottle(obj.path(iap), agent2);
    end
end
end