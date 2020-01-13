function Bottles = find_rainbow_cycles(obj, idx_next_state)
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

Bottles = [];
N = length(obj.Paths);
% Cycles = find_rainbow_cycles_helper(obj, idx_next_state, 1:N);
Cycles = find_rainbow_cycles_helper(obj, idx_next_state, obj.id);

for c = 1:length(Cycles)
    my_cycle = Cycles(c);
    cycle_color = my_cycle.id_agents;
%     if any(cycle_color == obj.id)
        for i = 1:length(my_cycle.id_cells)
            for j = 1:length(cycle_color)
%             for j = 1:length(obj.Paths)
                b1 = obj.getBottleId(my_cycle.id_cells(i), cycle_color(j));
%                 b1 = obj.getBottleId(my_cycle.id_cells(i), j);
    %             b2 = obj.getBottleId(my_cycle.id_cells(i), cycle_color(j));
                Bottles = [Bottles, b1];
            end
        end
%     end
end

Bottles = unique(Bottles);
%%%%%% new idea %%%%%%
if idx_next_state > 1 && obj.is_shared(idx_next_state)
    bottles_from_prev = setdiff(obj.sessions{idx_next_state - 1}, find(obj.bottle_cells == obj.path(idx_next_state-1)));
    Bottles = unique([Bottles, bottles_from_prev]);
end