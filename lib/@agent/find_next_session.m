function Bottles = find_next_session(obj, idx_next_state)
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

Cycles = obj.find_rainbow_cycles(idx_next_state);
% after finding all associated (cell,agent) pairs, get all the associated
% bottles
bottles_4_next_state = obj.getCellBottles(obj.path(idx_next_state));
bottles_4_cycles = [];
for c = 1:length(Cycles)
    for i = 2:length(Cycles(c).id_cells)
        this_bottle = obj.getBottle(Cycles(c).id_cells(i), Cycles(c).id_agents(i));
        bottles_4_cycles = [bottles_4_cycles this_bottle];
    end
end

Bottles = [bottles_4_next_state, bottles_4_cycles];