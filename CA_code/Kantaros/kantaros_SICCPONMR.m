clear; close all; clc;
addpath(genpath('../'))

% simulation time
h = 200;

% input bounds
umax = 1;
umin = -1;

% Kantaros Example Parameters
% create WS
ws = ws_points;

% create teams
T = cell(5,1);
T{1} = [1 2];
T{2} = [2 3];
T{3} = [3 4];
T{4} = [2 4 5];
T{5} = [1 5];
teams = generate_agents(T,ws);
pos = [4 10; 6 11; 12 11; 12 8; 9 5]';
v = 10*rand(5,1);

plot_kantaros(ws, pos);
% 0: need to meet
% 1: on the way to meeting
% 2: met
% meeting_flag = zeros(length(teams),1);
for t = 1:h
    % bookkeeping
    v = [v v(:,end)];
    for i = 1:length(teams)
        if teams(i).isThinking
%             if meeting_flag(i) == 0
                teams(i).getHungry;
%             elseif meeting_flag(i) == 1
%                 meeting_flag(i) = 0;
%             end
        elseif teams(i).isEating
            % move agents of Ti
%             meeting_flag(i) = 1;
            cp = find_closest_point(teams(i), pos, ws);
            if is_arrived(teams(i), cp, pos)
                total = sum(v(teams(i).robots,end));
                nr = length(teams(i).robots);
                v(teams(i).robots, end) = total*ones(nr,1)/nr;
                teams(i).finishEating();
            else
                for r = 1:length(teams(i).robots)
                   du = cp - pos(:,teams(i).robots(r));
                   if norm(du,2) > umax
                       du = umax*du/norm(du,2);
                   end
                   pos(:,teams(i).robots(r)) = pos(:,teams(i).robots(r)) + du;
                end
            end
        end     
    end
    plot_kantaros(ws, pos);
    pause(0.03);
    % more bookkeepin
end

    figure(2)
    clf;
    hold on
    axis([0 h 0 10])
    mycolors = jet(5);
    for n = 1:5
        plot(1:size(v,2), v(n,:), '-', ...
            'MarkerFaceColor',mycolors(n,:), 'MarkerEdgeColor',mycolors(n,:))
    end