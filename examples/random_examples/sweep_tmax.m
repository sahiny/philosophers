clear;clc;close all;
%% User Defined Parameters
num_iteration = 1000;
random_number = [1 3 4 7 10];% 7 9 10];
cycle_method = 'R2_2';
TMAX = 2:2:20;
Makespan = zeros(num_iteration,max(random_number), max(TMAX));
AllTimes = cell(num_iteration,max(random_number), max(TMAX));
for tmax = TMAX
    rng(0);
    Prob_succ = 1/tmax + (1-1/tmax)*rand(num_iteration,max(random_number),35);
    for r = random_number
        rng(0);
        eval(['random_', num2str(r), '_modified']);
%         prob_succ = parameters(:,5);
        %%
        %%
        % simulate
        for i = 1:num_iteration
            prob_succ = squeeze(Prob_succ(i,r,:));
            [time_elapsed, num_messages] = philosopher(Paths, prob_succ,'pre_load', ['rand', num2str(r), '_', cycle_method]);%, 'plot_stuff', ws); %, 'pre_load', );%, 'plot_stuff', ws);%, );
    %         [time_elapsed, num_messages] = philosopher(Paths, prob_succ,'pre_load', ['rand', num2str(r), '_', cycle_method], 'fix_seed', this_seed); %, 'pre_load', );%, 'plot_stuff', ws);%, );
            Makespan(i, r, tmax) = max(time_elapsed);
            AllTimes{i, r, tmax} = time_elapsed;
        end
        save('Philosopher_R_results_sweep_tmax')
    end
    
%     avg_makespan = zeros(10,1);
%     confidence_int = zeros(10,1);
%     for i = random_number
%     mi = find(Makespan(:,i)>0);
%     mi = Makespan(mi,i);
%     mydist = fitdist(mi, 'normal');
%     avg_makespan(i) = mean(mi);
%     a = mydist.paramci(0.05);
%     confidence_int(i) = mydist.mu - a(1);
%     end
end
