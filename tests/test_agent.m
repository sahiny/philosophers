clear;clc;

Paths = {[11 1 2 3 4 5 11]};
Paths{end+1} = [22 5 4 3 2 1 22];
% Paths{end+1} = [33 3 33];
% Paths{end+1} = [44 4 3 2 7 44];
% Paths{end+1} = [55 7 6 55];
% Paths{end+1} = [66 6 1 66];
Paths{end+1} = [77 1 2 3 4 5 77];
% Paths{end+1} = [88 5 4 3 2 1 88];

for i= 1:length(Paths)
    Agents{i} = agent(i,Paths{i});
    Agents{i}.Paths = Paths;
end

for i= 1:length(Paths)
    Agents{i}.createBottlesSharedWith(Agents);
end

Agents{1}.move();
Agents{3}.move();

Agents{1}.move();
Agents{3}.move();

Agents{2}.move();
Agents{1}.move();
Agents{1}.move();
Agents{1}.move();
Agents{1}.move();
1;