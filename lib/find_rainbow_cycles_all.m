function find_rainbow_cycles_all(Agents, Paths, version_number)

[Nodes, id_cell2id_node, adj] = getNodes(Paths);
rc_found = true;
while rc_found
    [Nodes, id_cell2id_node, adj, rc_found] = find_rainbow_cycles_centralized(Nodes, Paths, id_cell2id_node, adj);
end

is_shared = find_shared_status(Paths);

for i = 1:length(Agents)
    Agents{i}.sessions = cell(1,length(Agents{i}.path));
    for j = 1:length(Agents{i}.path)
        id_cell = Agents{i}.path(j);
        id_nodes = id_cell2id_node{id_cell};
        for n = 1:length(id_nodes)
            id_cells = Nodes{id_nodes(n)}.id_cell;
            if version_number == 2
                % find the next cell which is not included
                ia = ismember(Agents{i}.path, id_cells);
                ia(1:j-1) = 1;
                jj = find(ia == 0, 1);
                ia(1:j-1) = 0;
                ia(jj:end) = 0;
            end
            for c = 1:length(id_cells)
                if ~isempty(Agents{i}.path(j:end)==id_cells(c)) % if c is in the future
                    if version_number == 2
                        jj = find(Agents{i}.path(j:end)==id_cells(c)) + j-1;
                        if ia(jj) == 1 % if there is no skip cells in between
                            bottle_id = find(Agents{i}.bottle_cells == id_cells(c));
                            Agents{i}.sessions{j} = unique([Agents{i}.sessions{j} bottle_id]);
                        end
                    elseif version_number == 3
                        bottle_id = find(Agents{i}.bottle_cells == id_cells(c));
                        Agents{i}.sessions{j} = unique([Agents{i}.sessions{j} bottle_id]);
                    end
                end
            end
        end
        1;
        if version_number == 3
            % claim bottles from previous
            if j > 1 && is_shared(Agents{i}.path(j))
                bottles_from_prev = setdiff(Agents{i}.sessions{j - 1}, find(Agents{i}.bottle_cells == Agents{i}.path(j-1)));
                Agents{i}.sessions{j} = unique([Agents{i}.sessions{j} bottles_from_prev]);
            end
        end
    end
end