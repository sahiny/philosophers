function Cycles = find_rainbow_cycles_merge_helper(obj, idx_next_state, root_nodes, root_colors)
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

Paths = obj.Paths;
N = length(Paths);
num_colors = N; % num_agents

% n = node(id_cell, parent, parent_colors, ancestor_cells, num_colors)
root = node(root_nodes, [], root_colors, [], num_colors);

%%%%%%%%%% NEW IDEA %%%%%%%%%%%%%%%
open_list = [];
for p = root_colors
    for n = root.id_cell
        id_succ = Paths{p} == n;
        id_succ = [false id_succ(1:end-1)];
        succ = Paths{p}(id_succ);
        for s = succ
            if is_shared(s) && ~any(root_nodes == s)
                new_node = node(s, root, p, root_nodes, num_colors);
                open_list = [open_list new_node];
            end
        end
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
            if idx_child == length(Paths{c})
                continue
            elseif c == obj.id && i < idx_next_state
                return
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            id_child_c = Paths{c}(i+ 1);
            if ~is_shared(id_child_c)
                continue
            end
            child_c = node(id_child_c, node2explore, ...
                [node2explore.parent_colors c],...
                [node2explore.ancestor_cells node2explore.id_cell],...
                num_colors);
            % check if it creates a non-simple cycle
            if ~isempty(find(child_c.ancestor_cells == child_c.id_cell,1)) 
            % cycle detected
                if any(root.id_cell == child_c.id_cell) 
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
    % find new_root_nodes
    new_root_nodes = [];
    new_root_colors = [];
    for c = 1:length(Cycles)
        new_root_nodes = [new_root_nodes Cycles(c).id_cells];
        new_root_colors = [new_root_colors Cycles(c).id_agents];
    end
    new_root_nodes = unique(new_root_nodes);
    new_root_colors = unique(new_root_colors);
    Cycles2 = find_rainbow_cycles_merge_helper(obj, idx_next_state, new_root_nodes, new_root_colors);
    if ~isempty(Cycles2)
        Cycles = Cycles2;
    end
else
    1;
end
