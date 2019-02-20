function Cycles = find_polycycles_containing(obj, idx_state)
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
root = [id_cell, id_agent, id_cell2];

%%%%%%%

% keep a fifo open list for paths to explore
open_list = {root};
closed_list = {};

while ~isempty(open_list)
    % fifo list
    new_path = open_list{end};
    open_list(end) = [];
    %%%% Not sure if closed list is needed
    closed_list{end+1} = new_path; 
    
    id_cell2explore = new_path(end,end); 

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
                    if is_shared
                        break
                    end
                end
            end
            if is_shared
                new_edge = [id_cell2explore, c, id_child_c];
                % check if it creates a cycle
                %if ~isempty(find(new_path(:,1) == id_child_c,1)) 
                if id_child_c == new_path(1,1) % simple cycle 
                    if length(unique([new_path(:,2);c])) > 1 % at least 2 colors
                        Cycles{end+1} = [new_path; new_edge];
                    end
                else
                    if ~isempty(find(new_path(:,1) == id_child_c,1))
                        break;
                    end
%                         1; % not a simple-cycle, stop exploring this branch
%                     end
                %else
                    % no cycle detected
                    % check if this edge is explored before
                    i1 = find(new_path(:,1) == new_edge(1));
                    i2 = find(new_path(:,1) == new_edge(1));
                    ic = find(new_path(:,1) == new_edge(1));
                    if isempty(intersect(intersect(i1, i2), ic))
                        open_list{end+1} = [new_path; new_edge];
                    end
                end
            end
        end
    end
end
1;
% if a cycle is found, search for new cycles starting from the nextnext state
if ~isempty(Cycles) && idx_state < length(Paths{obj.id})
%     for c = 1:length(Cycles)
        Cycles2 = obj.find_polycycles_containing(idx_state +1);
        Cycles = [Cycles, Cycles2];
%     end
else
    1;
end
