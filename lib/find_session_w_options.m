function Bottles = find_session_w_options(obj, idx_next_state, cycle_method)
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
%   Bottles          - bottle array that must claimed before moving onto next_state
%

if strcmp(cycle_method, 'R')
%     bottles_4_cycles = find_rainbow_cycles_sep17(obj,idx_next_state);
    bottles_4_cycles = find_rainbow_cycles_merge(obj,idx_next_state);
elseif strcmp(cycle_method, 'SR')
    bottles_4_cycles = find_stuttered_rainbows_eqv_classes3(obj, idx_next_state);
elseif strcmp(cycle_method, 'C')
    bottles_4_cycles = find_cycles(obj,idx_next_state);
end

bottles_4_next_state = find(obj.bottle_cells == obj.path(idx_next_state));

Bottles = unique([bottles_4_next_state, bottles_4_cycles]);

