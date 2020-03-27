clear;close all;clc;
id_agent = 1;
idx_next_state = 2;
Paths = {[11 1 2 3 4 5 11]};
Paths{end+1} = [22 5 4 3 2 1 22];
% Paths{end+1} = [33 3 33];
% Paths{end+1} = [44 4 3 2 7 44];
% Paths{end+1} = [55 7 6 55];
% Paths{end+1} = [66 6 1 66];
% Paths{end+1} = [77 1 2 3 4 5 77];
% Paths{end+1} = [88 5 4 3 2 1 88];

C = find_session(id_agent, idx_next_state,  Paths)
