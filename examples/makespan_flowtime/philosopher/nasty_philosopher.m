% Number of robots
N = 3;
% Workspace
numRows = 30;
numCols = 30;
parameters = [...
 19,24,3,8, 0.2;
 7,18,6,6,0.4;
 18,27,16,2,1];
 
Paths = {[5:10:99]}; %1
Paths{end+1} = 41:1:50; %2
Paths{end+1} = 98:-10:1; %2

% Init/Final Conditions, Delay Prob
initial_locations = zeros(1,N);
final_locations = zeros(1,N);
for i = 1:N
   initial_locations(i) = Paths{i}(1);
   final_locations(i) = Paths{i}(end);
end
% Obstacles
obstacles = find(zeros(10, 10));
ws = create_workspace(numRows, numCols, obstacles);