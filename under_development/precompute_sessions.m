clear all;clc;
cycle_method = 'R';
for random_number = [1 3 4 5 6 7 8 9 10]
%koenig example
eval(['Koenig_random_', num2str(random_number)]);

% Define agents, find drinking sessions
Agents = cell(1,N);
for i = 1:N
    Agents{i} = agent(i,Paths{i});
    Agents{i}.Paths = Paths;
    Agents{i}.prob_succ = parameters(i, 5);
end
% create shared resources
for i= 1:length(Paths)
    Agents{i}.createBottlesSharedWith(Agents);
end
% find drinking sessions
for i= 1:length(Paths)
    Agents{i}.findDrinkingSessions(cycle_method);
end
set_initial_conditions(Agents);

mystr = ['Koenig_rand', num2str(random_number), '_', cycle_method];
clear i n numCols numRows obstacles random_number x y
save(mystr);
end