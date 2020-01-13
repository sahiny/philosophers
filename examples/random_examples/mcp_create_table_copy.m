clear;clc;close all;
%% User Defined Parameters

num_iteration = 1000;
random_number = [1 2 3 4 5 6 7 8 9 10];
Makespan = zeros(num_iteration, max(random_number));
AllTimes = cell(num_iteration,max(random_number));

for r = random_number
    rng(0);
    eval(['random', num2str(r)]);
    prob_succ = parameters(:,5);
    %%
    max_eta = length(Paths{1})*prob_succ(1);
    max_index = 1;
    for pp = 2:length(Paths)
        if max_eta < length(Paths{pp})*prob_succ(pp)
            max_index = pp;
            max_eta = length(Paths{pp})*prob_succ(pp);
        end
    end
    prob_succ(max_index) = 0.1;
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
my_str = 'changed prob_succ of maxeta = length(Paths{pp})*prob_succ(pp) to 0.1';
save('Mcp_results_maxeta_worstcase.mat');
