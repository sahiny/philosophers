function check_stats()
filename = 'Koenig_R_results_v3_Sep_22_2019.mat';
load(filename);

avg_avg_arrival = zeros(10,1);
avg_makespan = zeros(10,1);

for i = 1:10
    total_avg_arrival = 0;
    total_makespan = 0;
    for j = 1:1000
        % avg_arrival
        arr_j = sum(AllTimes{j,i})/35;
        total_avg_arrival = total_avg_arrival + arr_j;
        % makespan
        makespan_j = max(AllTimes{j,i});
        total_makespan = total_makespan + sum(makespan_j);
    end
    avg_avg_arrival(i) = total_avg_arrival/1000;
    avg_makespan(i) =  total_makespan/1000;
end
1;
    