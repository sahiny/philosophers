clear;close all;clc;

% Dining Philosopher Example
%% User Defined Parameters
% number of philosophers
N = 6;
% time horizon
h = 200;
% getting hungry probability
p_hungry = 0.1*ones(1,N);
% finishing eating probability
p_eating = 0.3*ones(1,N);

% %% Debugging purposes
% p_hungry = ones(1,N);
% p_eating = ones(1,N);

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
    
end
% fij is the fork they share
fij = fork(N, agents(N), 1, 0, 1);
agents(1).addForks(fij);

% fji is the fork they share
fij = fork(N, agents(1), 0, 1, 0);
agents(N).addForks(fij);  

%% Simulation
% bookkeeping
states = zeros(N,h);
states2 = zeros(N,h);
states4 = ones(N,1);
for i = 1:h
   % each agent decides to go hungry/finish eating
    for n = 1:N    
%           switch agents(n).diningState
%             case 'thinking'
%                 states(n,i) = 1;
%                 states4 = [states4 states4(:,end)];
%                 states4(n,end) = 1;
%             case 'hungry'
%                 states(n,i) = 2;
%                 states4 = [states4 states4(:,end)];
%                 states4(n,end) = 2;
%               case 'eating'
%                 states(n,i) = 3;
%                 states4 = [states4 states4(:,end)];
%                 states4(n,end) = 3;
%           end
        if agents(n).isThinking & rand(1) < p_hungry(n)
            agents(n).getHungry;
        elseif agents(n).isEating & rand(1) < p_eating(n)
            agents(n).finishEating;
        end     
        
%           switch agents(n).diningState
%             case 'thinking'
%                 states2(n,i) = 1;
%             case 'hungry'
%                 states2(n,i) = 2;
%                 1;
%             case 'eating'
%                 states2(n,i) = 3;
%           end
    end
%     
    for n = 1:N
          switch agents(n).diningState
            case 'thinking'
                states(n,i) = 1;
                states4 = [states4 states4(:,end)];
                states4(n,end) = 1;
            case 'hungry'
                states(n,i) = 2;
                states4 = [states4 states4(:,end)];
                states4(n,end) = 2;
              case 'eating'
                states(n,i) = 3;
                states4 = [states4 states4(:,end)];
                states4(n,end) = 3;
          end
    end
    
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