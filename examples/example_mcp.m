clear;clc;close all;
% Simple example showing agents can follow each other
%% User Defined Parameters
random_number = 1;
% eval(['Koenig_random_', num2str(random_number)]);
Koenig_random_1;

% load('mcp_koenig1_crash_a2_a11')

makespan = zeros(100,1);
messages = zeros(100,1);
% simulate
for i = 1:1000
[time_elapsed, num_messages] = mcp(Paths, parameters(:,5));%, ...
    %'plot_stuff', ws, 'fix_seed', this_seed);
    disp(['makespan = ', num2str(max(time_elapsed))]);
    disp(['num_msg = ', num2str(sum(num_messages))]);
    makespan(i) = max(time_elapsed);
    messages(i) = sum(num_messages);
end

1;