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
Bottles = obj.sessions{idx_next_state};
