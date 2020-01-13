clear all;clc;
for random_number = [1 2 3 4 5 6 7 8 9 10]
%koenig example
eval(['Koenig_random_', num2str(random_number), '_modified']);
disp(' ------------ ')
random_number

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
is_shared = find_shared_status(Paths);
for i = 1:N
    Agents{i}.sessions = cell(1,length(Agents{i}.path));
    for j = 1:length(Agents{i}.path)
        id_cell = Agents{i}.path(j);
        % find the next free cell
        if ~is_shared(id_cell)
            continue
        end
        for k = j+1:length(Agents{i}.path)
            if ~is_shared(Agents{i}.path(k))
                m = k-1;
                break
            end
            m = k;
        end
        cells = Agents{i}.path(j:m);
        Bottles = [];
        for c = cells
            b = find(Agents{i}.bottle_cells == c);
            Bottles = [Bottles b];
        end
        Agents{i}.sessions{j} = unique(Bottles);
    end
end
set_initial_conditions(Agents);
disp(' ------------ ')

mystr = ['Koenig_rand', num2str(random_number), '_naive'];
clear i p n numCols numRows obstacles random_number x y prob_succ
save(mystr);
end