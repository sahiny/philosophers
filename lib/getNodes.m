function [Nodes, id_cell2id_node, adj] = getNodes(Paths)

% find max state
max_state_id = 0;
for p = 1:length(Paths)
    1;
    for c = 1:length(Paths{p})
        id_cell = Paths{p}(c);
        if id_cell > max_state_id
            max_state_id = id_cell;
        end
    end
end

% create adj with colors
state_bool = zeros(max_state_id,1);
adj = cell(max_state_id, length(Paths));
for p = 1:length(Paths)
    1;
    for c = 1:length(Paths{p})
        if c < length(Paths{p})
            % don't add self loops
            if Paths{p}(c+1) == Paths{p}(c)
                continue;
            else
                adj{Paths{p}(c), p} = [adj{Paths{p}(c), p}; Paths{p}(c+1)];
            end
        end
        state_bool(Paths{p}(c)) = 1;
    end
end

% create nodes
Nodes = cell(1, sum(state_bool));
id_cell2id_node = cell(1, max_state_id);
j = 1;
for s = 1:max_state_id
    if state_bool(s)
        mynode = node(s, [], [], [], length(Paths));
        mynode.id = j;
        mynode.children_id_node = cell(1, length(Paths));
        mynode.children_id_cell = cell(1, length(Paths));
        Nodes{j} = mynode;
        id_cell2id_node{s} = j;
        j = j+1;
    end
end

% add children
for n = 1:length(Nodes)
    mynode = Nodes{n};
    for p = 1:length(Paths)
        % check if mynode this outgoing edge
        if ~isempty(adj{mynode.id_cell, p})
            mynode.children_id_node{p} = id_cell2id_node{adj{mynode.id_cell, p}};
            mynode.children_id_cell{p} = adj{mynode.id_cell, p};
        end
        1;
    end
end
1;