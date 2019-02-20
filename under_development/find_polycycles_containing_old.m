function Cycles = find_polycycles_containing_old(obj, idx_state)
% finds all cycles consisting only of shared states and obj.path(idx_state) 
% with at least 2 different colored edges
%
% Usage:
%   - Cycles = find_polycycles_containing(agent, idx_state)
%
% Inputs:
%   agent        - a
%   idx_state    - index of the next_state agent_id wants to occupy
%
% Outputs:
%   Bootles      - bottle array that must claimed before moving onto next_state
%


Cycles = [];
if obj.is_shared(idx_state) == 0
    return
elseif idx_state >= length(obj.path) % return empty if final state
    return
end

% else, find all cycles
id_agent = obj.id;
Paths = obj.Paths;
num_colors = length(Paths); % num_agents
id_cell = obj.path(idx_state);
id_cell2 = obj.path(idx_state+1);

%%%%%%%%% might change this if cycles starting with different color needed

% start the search for cycles
% edge(id_cell1, color, id_cell2, parent, ancestors, ancestor_colors, ancestor_cells)
root = edge(id_cell, id_agent, id_cell2, [], id_agent, id_cell);

%%%%%%%

% keep a fifo open list for nodes to explore
open_list = root;
closed_list = [];

while ~isempty(open_list)
    % fifo list
    edge2explore = open_list(end);
    id_cell2explore = edge2explore.id_cell2; 
    open_list(end) = [];
    closed_list = [closed_list; 
        [edge2explore.id_cell1, edge2explore.color, edge2explore.id_cell2]];
    % find successors of node2explore
    for c = 1:length(Paths)
        [~,idx_child] = find(Paths{c} == id_cell2explore);
        for i = idx_child 
            %%%%%%% Make sure this is correct %%%%%%%
            if idx_child == length(Paths{c})
            % Not a Cycle since there are no edges from the final state
                continue
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            id_child_c = Paths{c}(i + 1);
            %%%%%%%%%% Make Shared State Vector a field for each agent
            % check if free state
            is_shared = false;
            for c2 = 1:length(Paths)
                if c2 == c
                    continue
                else
                    is_shared = ~isempty(find(Paths{c2} == id_child_c,1));
                    break
                end
            end
            if is_shared
                new_edge = edge(id_cell2explore, c, id_child_c, ...
                    edge2explore, unique([edge2explore.ancestor_colors c]),...
                    unique([edge2explore.ancestor_cells id_cell2explore]));
                % check if it creates a cycle
                if ~isempty(find(new_edge.ancestor_cells == new_edge.id_cell2,1)) 
                    if new_edge.id_cell2 == root.id_cell1 % simple cycle 
                        if length(new_edge.ancestor_colors) > 1 % at least 2 colors
                            this_cycle = struct();
                            this_cycle.id_cells = new_edge.ancestor_cells;
                            this_cycle.id_agents = new_edge.ancestor_colors;
                            Cycles = [Cycles ,this_cycle];
                            Cycles_cells = unique([Cycles_cells new_edge.ancestor_cells]);
                            Cycles_agents = unique([Cycles
                        end
                    else
                        1; % not a simple-cycle, stop exploring this branch
                    end
                else
                    % no cycle detected
                    % check if this edge is explored before
                    i1 = find(closed_list(:,1) == new_edge.id_cell1);
                    i2 = find(closed_list(:,3) == new_edge.id_cell2);
                    ic = find(closed_list(:,2) == new_edge.color);
%                     if isempty(intersect(intersect(i1, i2), ic))
                        open_list = [open_list new_edge];
%                     end
                end
            end
        end
    end
end

% if a cycle is found, search for new cycles starting from the nextnext state
if ~isempty(Cycles) && idx_state < length(Paths{obj.id})
%     for c = 1:length(Cycles)
        Cycles2 = obj.find_polycycles_containing(idx_state +1);
        Cycles = [Cycles, Cycles2];
%     end
else
    1;
end
