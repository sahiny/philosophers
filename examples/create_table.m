clear all;clc;close all;

num_iteration = 1000;
random_number = 5;%[1 3 4 5 6 7 8 9 10];
my_method = 'C';

Time_elapsed = cell(max(random_number),1);
Seeds = cell(max(random_number),num_iteration);
for ri = 1:length(random_number)
    r = random_number(ri);
    time_elapsed = zeros(num_iteration, 35);
    disp(['%%%%%%%%%%%% RANDOM ', num2str(r), '%%%%%%%%%%%%%%%'])
    for i = 1:num_iteration
        if mod(i,50) == 0 
            disp(['---- Iteration: ', num2str(i)]);
        end
        [t, seed_t] = example_results_Koenig(r, 'cycle_method',my_method, 'pre_load');
        time_elapsed(i,:) = t;
        Seeds{r,i} = seed_t;
    end
    Time_elapsed{r} = time_elapsed;
    save(['table_results_',my_method, '_over', num2str(num_iteration),'runs']);
end
% Time_elapsed2 = max(Time_elapsed,[],2);
% Time_elapsed3 = Time_elapsed2(find(Time_elapsed2>0));
% mean(Time_elapsed3);

Time_elapsed2 = cell(max(random_number),1);
Time_elapsed3 = cell(max(random_number),1);
average_makespan = zeros(max(random_number), 1);
for r = random_number
    Time_elapsed2{r} = max(Time_elapsed{r},[],2);
    Time_elapsed3{r} = Time_elapsed2{r}(find(Time_elapsed2{r}>0));
    average_makespan(r) = mean(Time_elapsed3{r});
end

save(['table_results_',my_method, '_over', num2str(num_iteration),'runs']);

    
