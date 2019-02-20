function createBottlesSharedWith(obj, Agents)
% creates a bottle for each state sharedWith Agents
obj.is_shared = false(length(obj.path),1);
for a = 1:length(Agents)
    agent2 = Agents{a};
    if agent2.id == obj.id
        continue
    end
    [~, ia, ~] = intersect(obj.path, agent2.path);
    obj.is_shared(ia) = true;
    for iap = ia'
        obj.createBottle(obj.path(iap), agent2);
    end
end
if sum(obj.is_shared) == length(obj.path)
    disp('Conflict, no free states')
end