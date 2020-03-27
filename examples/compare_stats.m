function compare_stats()
% file 1
filename = 'Mcp_results_Sep_22_19.mat';
load(filename);
AllTimes1 = AllTimes;

% file 2
filename = 'Koenig_R_results_v3_Sep_22_2019.mat';
load(filename);
AllTimes2 = AllTimes;


% file 3
filename = 'Koenig_R2_2_results_oct13_2019.mat';
load(filename);
AllTimes3 = AllTimes;


% % file 2
% filename = 'Kiva_R2_2_results_oct14_2019_prob[0.1-1].mat';
% load(filename);
% AllTimes2 = AllTimes;
% 
% 
% % file 3
% filename = 'Mcp_results_Oct1_19_random_prob_succ_uniform(0.1-1].mat';
% load(filename);
% AllTimes3 = AllTimes;

avg_avg_arrival = zeros(10, 3);
avg_makespan = zeros(10, 3);
Valid = zeros(10,3);
max_time = 0;
for i = 1:10
    total_avg_arrival = 0;
    total_makespan = 0;
    
    total_avg_arrival2 = 0;
    total_makespan2 = 0;
    
    total_avg_arrival3 = 0;
    total_makespan3 = 0;
    
    valid1 = 0;
    valid2 = 0;
    valid3 = 0;
    for j = 1:1000
        % max time
        if max_time < max(AllTimes1{j,i})
            max_time = max(AllTimes1{j,i});
        end
        % avg_arrival
        if min(AllTimes1{j,i}) >= 0
            valid1 = valid1 + 1;
            arr_j = sum(AllTimes1{j,i})/35;
            total_avg_arrival = total_avg_arrival + arr_j;

            % makespan
            makespan_j = max(AllTimes1{j,i});
            total_makespan = total_makespan + sum(makespan_j);
        else
            1;
        end
        
        if min(AllTimes2{j,i}) >= 0 
            valid2 = valid2 + 1;
            arr_j = sum(AllTimes2{j,i})/35;
            total_avg_arrival2 = total_avg_arrival2 + arr_j;

            makespan_j = max(AllTimes2{j,i});
            total_makespan2 = total_makespan2 + sum(makespan_j);
        else
            1;
        end
        
        %%
        if min(AllTimes3{j,i}) >= 0 
            valid3 = valid3 + 1;
            arr_j = sum(AllTimes3{j,i})/35;
            total_avg_arrival3 = total_avg_arrival3 + arr_j;

            makespan_j = max(AllTimes3{j,i});
            total_makespan3 = total_makespan3 + sum(makespan_j);
        else
            1;
        end
    end
    avg_avg_arrival(i,1) = total_avg_arrival/valid1;
    avg_makespan(i,1) =  total_makespan/valid1;
    
    avg_avg_arrival(i,2) = total_avg_arrival2/valid2;
    avg_makespan(i,2) =  total_makespan2/valid2;
    
    avg_avg_arrival(i,3) = total_avg_arrival3/valid3;
    avg_makespan(i,3) =  total_makespan3/valid3;
    
    Valid(i, :) = [valid1 valid2 valid3];
end
1;

disp('#########################')
disp('random_prob_succ(0-1)')
disp('#########################')

disp('--- avg_avg_arrival ---');

for i = [1 3 4 7 8 9]
    [~,j] = min(avg_avg_arrival(i, :));
    
    if j == 1
        disp(['<strong>', num2str(avg_avg_arrival(i,1),'%3.2f'),'</strong>   ', num2str(avg_avg_arrival(i, 2),'%3.2f'), '   ' , num2str(avg_avg_arrival(i, 3),'%3.2f')])
    elseif j == 2
        disp([ num2str(avg_avg_arrival(i,1),'%3.2f'), '   <strong>', num2str(avg_avg_arrival(i, 2),'%3.2f'),'</strong>   ', num2str(avg_avg_arrival(i, 3),'%3.2f')])
    elseif j == 3
        disp([ num2str(avg_avg_arrival(i,1),'%3.2f'), '   ', num2str(avg_avg_arrival(i, 2),'%3.2f'),'   <strong>', num2str(avg_avg_arrival(i, 3),'%3.2f'), '</strong>'])
    end
end

disp('--- avg_makespan ---');

for i = [1 3 4 7 8 9]
    [~,j] = min(avg_makespan(i,:));
    
    if j == 1
        disp(['<strong>', num2str(avg_makespan(i,1),'%3.2f'),'</strong>   ', num2str(avg_makespan(i, 2),'%3.2f'), '   ' , num2str(avg_makespan(i, 3),'%3.2f')])
    elseif j == 2
        disp([ num2str(avg_makespan(i,1),'%3.2f'), '   <strong>', num2str(avg_makespan(i, 2),'%3.2f'),'</strong>   ', num2str(avg_makespan(i, 3),'%3.2f')])
    elseif j == 3
        disp([ num2str(avg_makespan(i,1),'%3.2f'), '   ', num2str(avg_makespan(i, 2),'%3.2f'),'   <strong>', num2str(avg_makespan(i, 3),'%3.2f'), '</strong>'])
    end
end
1;