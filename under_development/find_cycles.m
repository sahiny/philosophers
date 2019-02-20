function Bottles = find_cycles(obj, idx_state)
% finds all cycles consisting only of shared states and obj.path(idx_state) 
% with at least 2 different colored edges
%
% Usage:
%   - Cycles = find_cycles(agent, idx_state)
%
% Inputs:
%   obj          - philosopher
%   idx_state    - index of the next_state agent_id wants to occupy
%
% Outputs:
%   Bottles      - bottle array that must claimed before moving onto next_state

Bottles = [];
Cycles = {};

Paths = obj.Paths;
% find shared/free status of the states
is_shared = find_shared_status(Paths);

% return no cycles if one of the next 2 states is free or it's final state
if idx_state >= length(obj.path) 
    return
elseif ~is_shared(obj.path(idx_state))
    return
elseif ~is_shared(obj.path(idx_state+1))
    return
end

% create the non-colored digraph
G = create_digraph(Paths);
[I,J,S] = find(G.adj);

% keep a fifo open list for walks to explore (cycle = closed walk)
id_root = obj.path(idx_state);
id_cell2 = obj.path(idx_state+1);
open_list = {[id_root; id_cell2]};
closed_list = {};


while ~isempty(open_list)
    % pop from fifo list
    walk2explore = open_list{end}; 
    open_list(end) = [];
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
        % otherwise check for circles
        if any(walk2explore == succ)
            % circle detected!
            if succ == id_root
                closed_walk = [walk2explore; succ];
                edge_colors = get_edge_colors(Paths, closed_walk, obj.id);
                bottles = get_cycle_bottles(obj, closed_walk, edge_colors);
                Bottles = unique([Bottles bottles]);
                Cycles{end+1} = closed_walk;
            else
                1; % a cycle not including root, so stop to avoid inf loop
            end
        else
            open_list{end+1} = [walk2explore; succ];
        end
    end
end

% if a cycle is found, search for new cycles starting from the nextnext state
if ~isempty(Cycles) && idx_state < length(Paths{obj.id})
%     for c = 1:length(Cycles)
        Bottles2 = find_cycles(obj,idx_state +1);
        Bottles = unique([Bottles, Bottles2]);
%     end
else
    1;
end
