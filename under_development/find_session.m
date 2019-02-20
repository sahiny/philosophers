function Bottles = find_session(obj, idx_next_state)
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

% Cycles = obj.find_rainbow_cycles(idx_next_state);
if obj.id == 9 && idx_next_state == 16
    1;
end
bottles_4_cycles = find_cycles(obj,idx_next_state);
% after finding all associated (cell,agent) pairs, get all the associated
% bottles
bottles_4_next_state = find(obj.bottle_cells == obj.path(idx_next_state));
% bottles_4_next_state = getCellBottles(obj, obj.path(idx_next_state));
    

Bottles = unique([bottles_4_next_state, bottles_4_cycles]);