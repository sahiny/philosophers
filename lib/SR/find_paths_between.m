function Path_segments = find_paths_between(Paths, id_cell1, id_cell2)
% finds path segments from id_cell1 to id_cell2 that contains only shared states
% set default output
Path_segments = {};
%% return empty if start/end cell is not shared
% find shared/free status of the states
is_shared = find_shared_status(Paths);
% if ~is_shared(id_cell1) || ~is_shared(id_cell2)
%     return
% end

%% create non-colored digraph consisting only of edges between shared states
G = create_digraph(Paths);
[I,J,S] = find(G.adj);

% keep a fifo open list for walks to explore (cycle = closed walk)
open_list = {id_cell1};
closed_list = {};

while ~isempty(open_list)
    % pop from fifo list
    walk2explore = open_list{1}; 
    open_list(1) = [];
    % add to the closed list
    closed_list{end+1} = walk2explore;
    % find successors of node2explore
    Succ = J((I == walk2explore(end)));
    for s = 1:length(Succ)
        succ = Succ(s);
        % if s is not shared, stop exploring this branch
        if ~is_shared(succ)
            continue
        end
        new_walk = [walk2explore; succ];
        new_walk_edges = [new_walk(1:end-1) new_walk(2:end)];
        if size(unique(new_walk_edges, 'rows'), 1) ~= size(new_walk_edges, 1)
            continue
        elseif any(walk2explore == succ)
            continue
        end
        % otherwise check for circles
        if any(id_cell2 == new_walk(end))
            % path segment detected!
            Path_segments{end+1} = new_walk;
        else
            % check repeating edges
            open_list{end+1} = new_walk;
        end
    end
end

% Cycles = remove_redundancy(Cycles);

% % if a cycle is found, search for new cycles starting from the nextnext state
% if ~isempty(Cycles) && idx_state < length(Paths{obj.id})
% %     for c = 1:length(Cycles)
%         obj.cycles{idx_state} = Cycles;
%         [Cycles2, depth2] = find_simple_cycles(obj,idx_state +1, Cycles);
%         Cycles = [Cycles Cycles2];
%         depth = [depth depth2];
% %     end
% else
%     1;
% end