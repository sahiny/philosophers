clear; close all; clc;
addpath(genpath('../'))

% create teams
T = cell(5,1);
T{1} = [1 2];
T{2} = [2 3];
T{3} = [3 4];
T{4} = [2 4 5];
T{5} = [1 5];
teams = generate_agents(T);

% create WS
[C, A] = ws_points;
1;
% need to meet if 0
meeting_flag = zeros(length(teams),1);
for t = 1:h
    % bookkeeping
    1;
    for i = 1:length(teams)
        if teams(i).isThinking && meeting_flag(i) == 0
            teams(i).getHungry;
        elseif teams(i).isEating
            % move agents of Ti
            cp = find_closest_point();
            for r = 1:length(T{i})
               du = cp - x(T{i}(r),:);
            end
        end     
    end
    % more bookkeepin
end
