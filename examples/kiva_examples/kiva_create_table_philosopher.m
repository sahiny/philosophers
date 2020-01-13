clear;clc;close all;
%% User Defined Parameters
num_iteration = 1000;
random_number = 8;
cycle_method = 'R2_2';

TMAX = 2:2:20;
Makespan = zeros(num_iteration,max(random_number), max(TMAX));
AllTimes = cell(num_iteration,max(random_number), max(TMAX));

for tmax = TMAX
    rng(0);
    Prob_succ = 1/tmax + (1-1/tmax)*rand(num_iteration,max(random_number),35);
    for r = random_number
        
        eval(['kiva_', num2str(r)]);
        %%
    %     prob_succ = 0.1+ 0.9*rand(35,1);
        %%
        % simulate
        for i = 1:num_iteration
            prob_succ = squeeze(Prob_succ(i,r,:));
            [time_elapsed, num_messages] = philosopher(Paths, prob_succ,'pre_load', ['Kiva', num2str(r), '_', cycle_method]);%, 'plot_stuff', ws); %, 'pre_load', );%, 'plot_stuff', ws);%, );
            Makespan(i,r,tmax) = max(time_elapsed);
            AllTimes{i,r,tmax} = time_elapsed;
        end
    end
end
% avg_makespan = zeros(10,1);
% confidence_int = zeros(10,1);
% for i = random_number
% mi = find(Makespan(:,i)>0);
% mi = Makespan(mi,i);
% % mydist = fitdist(mi, 'normal');
% avg_makespan(i) = mean(mi);
% % a = mydist.paramci(0.05);
% % confidence_int(i) = mydist.mu - a(1);
% end

save('Kiva_philosopher_sweep_results_originalpaths_nov20_2019.mat')
% kiva_create_table_mcp;