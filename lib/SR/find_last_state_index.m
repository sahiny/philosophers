function k = find_last_state_index(SR_Cycles, obj, idx_state)
k = 0;
nodes = [];
for c = 1:size(SR_Cycles,1)
    nodes = [nodes; SR_Cycles{c,3}];
end
nodes = unique(nodes);

Paths = obj.Paths;
is_shared = find_shared_status(Paths);
j=1;
while is_shared(obj.path(idx_state + j)) 
    if ~isempty(find(nodes == obj.path(idx_state + j),1))
        k = j;
    end
    j = j+1;
    
    if idx_state + j > length(obj.path)
        break
    end
end