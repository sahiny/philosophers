function Conflicts = findConflicts(obj, Agents)
	Conflicts = cell(length(obj.path),1);
	for a = 1:length(Agents)
        if Agents(a).id == obj.id
            continue
        end
        [~, ia, ~] = intersect(obj.path, Agents(a).path);
        for iap = ia'
            Conflicts{iap} = [Conflicts{iap} a];
        end
	end
end