function createBottlesSharedWith(obj, Agents)
%% get rid of stutter
Paths = obj.Paths;
for n = 1:length(Paths)
   p = 2;
   while p <= length(Paths{n})
       if Paths{n}(p) == Paths{n}(p-1)
         Paths{n}(p) = [];
       else
         p = p + 1;
       end
   end
end
%%
obj.Paths = Paths;
obj.path = Paths{obj.id};
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
    disp(['Conflict, no free states for Agent',num2str(obj.id)])
end