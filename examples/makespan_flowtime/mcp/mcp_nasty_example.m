clear;clc;close all;
%% User Defined Parameters
num_iteration = 1000;
cycle_method = 'R';
Makespan = zeros(num_iteration,1);
AllTimes = cell(num_iteration,1);
    rng(0);
    eval(['nasty_mcp']);
    prob_succ = parameters(:,5);
    %%
%     prob_succ = 0.1+ 0.9*rand(35,1);
    %%
    % simulate
    for i = 1:num_iteration
        [time_elapsed, num_messages] = mcp(Paths, prob_succ);
        Makespan(i) = max(time_elapsed);
        AllTimes{i} = time_elapsed;
    end

avg_makespan = zeros(1,1);
confidence_int = zeros(1,1);
for i = 1
mi = find(Makespan(:,i)>0);
mi = Makespan(mi,i);
% mydist = fitdist(mi, 'normal');
avg_makespan(i) = mean(mi);
% a = mydist.paramci(0.05);
% confidence_int(i) = mydist.mu - a(1);
end
avg_flowtime = 0;
for i = 1:num_iteration
    avg_flowtime = avg_flowtime + sum(AllTimes{i});
end
avg_flowtime = avg_flowtime/num_iteration;
save('mcp_nasty_results_dec23_2019')
