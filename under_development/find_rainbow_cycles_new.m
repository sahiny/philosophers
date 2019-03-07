function Bottles = find_rainbow_cycles_new(obj, idx_next_state)
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

Cycles = find_rainbow_cycles_helper(obj, idx_next_state);

if isempty(Cycles)
    return;
end

for c = 1:length(Cycles)
    my_cycle = Cycles(c);
    for i = 1:length(my_cycle.id_cells)
        b = obj.getBottleId(my_cycle.id_cells(i), my_cycle.id_agents(i));
        Bottles = [Bottles, b];
    end
end

Bottles = unique(Bottles);