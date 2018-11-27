function Cycles = find_rainbow_cycles(obj, idx_next_state)
% finds the next session of bottles that are required to move to next_state
% searches for simple rainbow cycles that is rooted at next_state and
% starts with the color of corresponding agent
%
% Usage:
%   - Cycles = find_session(id_agent, idx_next_state)
%
% Inputs:
%   id_agent        - id of the agent positive integer
%   idx_next_state   - index of the next_state agent_id wants to occupy
%
% Outputs:
%   Bootles          - bottle array that must claimed before moving onto next_state
%

id_agent = obj.id;
Paths = obj.Paths;
id_cell_next_state = obj.path(idx_next_state);
id_cell_nextnext_state = obj.path(mod(idx_next_state, length(obj.path)) + 1);
num_colors = length(Paths); % num_agents

% n = node(id_cell, parent, parent_colors, ancestor_cells, num_colors)
root = node(id_cell_next_state, [], [], [], num_colors);

% keep a fifo open list for nodes to explore
open_list = node(id_cell_nextnext_state, root, id_agent, id_cell_next_state, num_colors);
Cycles = [];

while ~isempty(open_list)
    % fifo list
    node2explore = open_list(1); 
    open_list(1) = [];
    % find successorts of node2explore
    for c = node2explore.colors_left
        [~,idx_child] = find(Paths{c} == node2explore.id_cell);
        for i = idx_child 
            %%%%%%% Not a Cycle %%%%%%%%%
            if idx_child == length(Paths{c})
                continue
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            id_child_c = Paths{c}(mod(i, length(Paths{c})) + 1);
            child_c = node(id_child_c, node2explore, ...
                [node2explore.parent_colors c],...
                [node2explore.ancestor_cells node2explore.id_cell],...
                num_colors);
            % check if it creates a non-simple cycle
            if ~isempty(find(child_c.ancestor_cells == child_c.id_cell)) 
            % cycle detected
                if child_c.id_cell == root.id_cell
                    this_cycle = struct();
                    this_cycle.id_cells = child_c.ancestor_cells;
                    this_cycle.id_agents = child_c.parent_colors;
                    Cycles = [Cycles ,this_cycle];
                else
                    1; % not a simple-cycle, stop exploring this branch
                end
            else
                % no cycle detected, keep looking
                open_list = [open_list child_c];
            end
        end
    end
end

% if a cycle is found, search for new cycles starting from the nextnext state
if ~isempty(Cycles) && idx_next_state < length(Paths{obj.id})
%     for c = 1:length(Cycles)
        Cycles2 = obj.find_rainbow_cycles(idx_next_state +1);
        Cycles = [Cycles, Cycles2];
%     end
else
    1;
end
