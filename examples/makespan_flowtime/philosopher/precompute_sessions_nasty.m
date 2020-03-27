clear all;clc;
cycle_method = 'R';
%koenig example
eval(['nasty_philosopher']);

% Define agents, find drinking sessions
Agents = cell(1,N);
initial_locations = zeros(N,1);
final_locations = zeros(N,1);
for i = 1:N
    prob_succ = parameters(i, 5);
    Agents{i} = agent(i,Paths, prob_succ);
    initial_locations(i) = Paths{i}(1);
    final_locations(i) = Paths{i}(end);
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

mystr = ['nasty_philosopher', '_', cycle_method];
clear i p n numCols numRows obstacles random_number x y prob_succ
save(mystr);