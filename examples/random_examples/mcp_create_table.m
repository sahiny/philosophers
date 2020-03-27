clear;clc;close all;
%% User Defined Parameters

num_iteration = 1000;
random_number = [1 3 4 6 7 8 9 10];
Makespan = zeros(num_iteration, max(random_number));
AllTimes = cell(num_iteration,max(random_number));

for r = random_number
    rng(0);
    eval(['random', num2str(r)]);
    prob_succ = parameters(:,5);
    %%
    prob_succ = 0.1 + rand(35,1)*0.9;
    %%
    for i = 1:num_iteration
        [time_elapsed, num_messages] = mcp(Paths, prob_succ);
        Makespan(i,r) = max(time_elapsed);
        AllTimes{i,r} = time_elapsed;

    end
end


% avg_makespan = zeros(10,1);
% confidence_int = zeros(10,1);
% for i = random_number
% mi = find(Makespan(:,i)>0);
% if isempty(mi)
%     continue
% end
% mi = Makespan(mi,i);
% mydist = fitdist(mi, 'normal');
% avg_makespan(i) = mydist.mu;
% a = mydist.paramci(0.05);
% confidence_int(i) = mydist.mu - a(1);
% end

save('Mcp_results_random_prob_succ_uniform(0.1-1].mat');
