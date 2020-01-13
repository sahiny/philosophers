clear;clc;close all;
%% User Defined Parameters
num_iteration = 1000;
random_number = [1 3 4 7 9 10];
cycle_method = 'R2_3';

Makespan = zeros(num_iteration,max(random_number));
AllTimes = cell(num_iteration,max(random_number));
for r = random_number
    rng(0);
    eval(['random', num2str(r), '_modified']);
    prob_succ = parameters(:,5);
    
    %%
%     max_eta = length(Paths{1})*prob_succ(1);
%     max_index = 1;
%     for pp = 2:length(Paths)
%         if max_eta < length(Paths{pp})*prob_succ(pp)
%             max_index = pp;
%             max_eta = length(Paths{pp})*prob_succ(pp);
%         end
%     end
%     prob_succ(max_index) = 0.1;
    %%
    
    % simulate
    for i = 1:num_iteration
        [time_elapsed, num_messages] = philosopher(Paths, prob_succ,'pre_load', ['rand', num2str(r), '_', cycle_method]);%, 'plot_stuff', ws); %, 'pre_load', );%, 'plot_stuff', ws);%, );
%         [time_elapsed, num_messages] = philosopher(Paths, prob_succ,'pre_load', ['rand', num2str(r), '_', cycle_method], 'fix_seed', this_seed); %, 'pre_load', );%, 'plot_stuff', ws);%, );
        Makespan(i,r) = max(time_elapsed);
        AllTimes{i,r} = time_elapsed;
    end
end

avg_makespan = zeros(10,1);
confidence_int = zeros(10,1);
for i = random_number
mi = find(Makespan(:,i)>0);
mi = Makespan(mi,i);
% mydist = fitdist(mi, 'normal');
avg_makespan(i) = mean(mi);
% a = mydist.paramci(0.05);
% confidence_int(i) = mydist.mu - a(1);
end
% my_str = 'changed prob_succ of maxeta = length(Paths{pp})*prob_succ(pp) to 0.1.mat';

save('Philosopher_R_results');