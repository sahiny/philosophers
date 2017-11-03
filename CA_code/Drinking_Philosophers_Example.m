clear;close all;clc;

% Drinking Philosopher Example
%% User Defined Parameters
% number of philosophers
N = 15;
% time horizon
h = 200;
% getting hungry probability
p_thirsty = 0.1*ones(1,N);
% finishing drinking probability
p_drinking = 0.3*ones(1,N);

%% Debugging purposes
% p_thirsty =  ones(1,N);
% p_drinking = ones(1,N);

%% Define agents
agents = [];
for i = 1:N
   agents = [agents agent(i)] ;
end

% Now distribute forks and tokens, keep H acyclic
for i=1:N-1
    
    % for each agent, j is the right neighbor
    j = i+1;
    
    % fij is the fork they share
    fij = fork(i, agents(j), 1, 0, 1);
    agents(i).addForks(fij);
    
    % fji is the fork they share
    fij = fork(i, agents(i), 0, 1, 0);
    agents(j).addForks(fij);   
    
    % id, sharedWith, holding, req, need, occupy
    % bij is the fork they share
    bij = bottle(i, agents(j), 1, 0, 0, 0);
    agents(i).addBottles(bij);
    
    % fji is the fork they share
    bij = bottle(i, agents(i), 0, 1, 0, 0);
    agents(j).addBottles(bij);   
    
end
% fij is the fork they share
fij = fork(N, agents(N), 1, 0, 1);
agents(1).addForks(fij);

% fji is the fork they share
fij = fork(N, agents(1), 0, 1, 0);
agents(N).addForks(fij);  

% bij is the bottle they share
bij = bottle(N, agents(N), 1, 0, 0, 0);
agents(1).addBottles(bij);

% bji is the bottle they share
bij = bottle(N, agents(1), 0, 1, 0, 0);
agents(N).addBottles(bij);   

%% Simulation
% bookkeeping
states = zeros(N,h);
states2 = zeros(N,h);
states4 = ones(N,1);
for i = 1:h
   % each agent decides to go thirsty/finish drinking
    for n = 2:N    
        if agents(n).isTranquil() & rand(1) < p_thirsty(n)
            agents(n).getThirsty([n, n-1]);
        elseif agents(n).isDrinking & rand(1) < p_drinking(n)
            agents(n).finishDrinking();
        end
                  switch agents(n).drinkingState
            case 'tranquil'
                states(n,i) = 1;
                states4 = [states4 states4(:,end)];
                states4(n,end) = 1;
            case 'thirsty'
                states(n,i) = 2;
                states4 = [states4 states4(:,end)];
                states4(n,end) = 2;
              case 'drinking'
                states(n,i) = 3;
                states4 = [states4 states4(:,end)];
                states4(n,end) = 3;
          end
    end
%     
%     for n = 1:N
%           switch agents(n).drinkingState
%             case 'tranquil'
%                 states(n,i) = 1;
%                 states4 = [states4 states4(:,end)];
%                 states4(n,end) = 1;
%             case 'thirsty'
%                 states(n,i) = 2;
%                 states4 = [states4 states4(:,end)];
%                 states4(n,end) = 2;
%               case 'drinking'
%                 states(n,i) = 3;
%                 states4 = [states4 states4(:,end)];
%                 states4(n,end) = 3;
%           end
%     end
    
end
% states3 = zeros(N,2*h);
% states3(:, 1:2:2*h-1) = states; 
% states3(:, 2:2:2*h) = states2; 

% sanity checks
% for n = 1:N
%     for t = 2:2*h
%         if states3(n,t) == 1
%             assert(states3(n,t-1)==1 || states3(n,t-1)==3, ...
%                 strcat('Agent', num2str(n), 'at time step: ',num2str(t) ,': Thinking before eating!'));
%         elseif states3(n,t) == 2
%             assert(states3(n,t-1)==1 || states3(n,t-1)==2, ...
%                 strcat('Agent ', num2str(n), ' at time step: ', num2str(t) ,': Hungry before thinking!'));
%         end
%     end
% end
% Now plot
figure(1)
clf
for n = 1:N
    subplot(N,1,n)
    hold on
%     bar(find(states(n,:) == 1), ones(1,length(find(states(n,:) == 1))), .5, 'b');
%     bar(find(states(n,:) == 2), ones(1,length(find(states(n,:) == 2))), .5, 'r');
%     bar(find(states(n,:) == 3), ones(1,length(find(states(n,:) == 3))), .5, 'g');
%     bar(find(states2(n,:) == 1) + .5, ones(1,length(find(states2(n,:) == 1))), .5, 'b');
%     bar(find(states2(n,:) == 2) + .5, ones(1,length(find(states2(n,:) == 2))), .5, 'r');
%     bar(find(states2(n,:) == 3) + .5, ones(1,length(find(states2(n,:) == 3))), .5, 'g');
axis normal
    xlim([0.5, size(states4, 2)+.5]);
    set(gca, 'XScale' ,'linear');
    bar(find(states4(n,:) == 1), ones(1,length(find(states4(n,:) == 1))), 1, 'b', 'EdgeColor', 'b');
    bar(find(states4(n,:) == 2), ones(1,length(find(states4(n,:) == 2))), 1, 'r', 'EdgeColor', 'r');
    bar(find(states4(n,:) == 3), ones(1,length(find(states4(n,:) == 3))), 1, 'g', 'EdgeColor', 'g');
    
end

% figure(1)
% clf
% for t = 1:2*h
%     
% end