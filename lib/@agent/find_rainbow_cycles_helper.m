function Cycles = find_rainbow_cycles_helper(obj, idx_next_state, root_color)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Change it to get rid of node class %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
Cycles = [];
is_shared = find_shared_status(obj.Paths);
if ~is_shared(obj.path(idx_next_state)) || idx_next_state == length(obj.path)
    return
%%%%% new idea
elseif idx_next_state < length(obj.path)
    if ~is_shared(obj.path(idx_next_state+1))
        return
    end
%%%%% new idea
end

id_agent = obj.id;
Paths = obj.Paths;
N = length(Paths);
id_cell_next_state = obj.path(idx_next_state);
id_cell_nextnext_state = obj.path(idx_next_state + 1);
num_colors = length(Paths); % num_agents

% n = node(id_cell, parent, parent_colors, ancestor_cells, num_colors)
root = node(id_cell_next_state, [], [], [], num_colors);


% % keep a fifo open list for nodes to explore
% open_list = node(id_cell_nextnext_state, root, id_agent, id_cell_next_state, num_colors);


%%%%%%%%%% NEW IDEA %%%%%%%%%%%%%%%
open_list = [];
for p = root_color
    id_p = Paths{p} == id_cell_next_state;
    id_p = [false id_p(1:end-1)];
    id_cell_next_p = Paths{p}(id_p);
    for i = 1:length(id_cell_next_p)
        new_node = node(id_cell_next_p(i), root, p, id_cell_next_state, num_colors);
        open_list = [open_list new_node];
    end
end
%%%%%%%%%% NEW IDEA %%%%%%%%%%%%%%%


while ~isempty(open_list)
    % fifo list
    node2explore = open_list(1); 
    open_list(1) = [];
    % find successorts of node2explore
    for c = node2explore.colors_left
        [~,idx_child] = find(Paths{c} == node2explore.id_cell);
        for i = idx_child 
            %%%%%%% Not a Cycle %%%%%%%%%
            if i == length(Paths{c})
                continue
            elseif c == obj.id && i < idx_next_state
                return
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            id_child_c = Paths{c}(mod(i, length(Paths{c})) + 1);
            child_c = node(id_child_c, node2explore, ...
                [node2explore.parent_colors c],...
                [node2explore.ancestor_cells node2explore.id_cell],...
                num_colors);
            % check if it creates a non-simple cycle
            if ~isempty(find(child_c.ancestor_cells == child_c.id_cell,1)) 
            % cycle detected
                if child_c.id_cell == root.id_cell
                    this_cycle = struct();
                    this_cycle.id_cells = child_c.ancestor_cells;
                    this_cycle.id_agents = child_c.parent_colors;
                    % find if there's a bottle to be claimed here
%                     if any(this_cycle.id_agents == obj.id)
                        Cycles = [Cycles ,this_cycle];
%                     end
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
    Cycles2 = [];
    is_valid = 0;
    for c = 1:length(Cycles)
        my_cycle = Cycles(c);
        cycle_cells = my_cycle.id_cells;
        if any(cycle_cells == obj.path(idx_next_state +1))
            is_valid = 1;
            break
        end
    end
    if is_valid
%         Cycles2 = obj.find_rainbow_cycles_helper(idx_next_state +1, 1:N);
        Cycles2 = obj.find_rainbow_cycles_helper(idx_next_state +1, obj.id);
    end
        Cycles = [Cycles, Cycles2];
%     else
%         Cycles = [];
%     end
%     end
else
    1;
end
