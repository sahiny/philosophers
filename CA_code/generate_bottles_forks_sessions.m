function [agents, bottles, forks, Sessions] = generate_bottles_forks_sessions(ws, paths, conflicts)
%
N = length(paths);
I = prod(ws.size);
bottles_table = cell(N,N,I);
bottles = cell(1,N);
bottle_id = 1;

% create agents
agents = [];
for n = 1:N
   agents = [agents agent(n)];
%    agents(n).setPath(paths{n});
%    agents(n).position = paths{n}(1);
%    agents(n).conflict = conflicts{n};
end

for n = 1:N
   % for agent n
   agent1_id = n;
   conflict = conflicts{n};
   for i = 1:sum(conflict.bool)
       % conflict #c
       c = find(conflict.bool, i);
       c = c(end);
       conflict_cell = paths{agent1_id}(c);
       % find agents in the conflict
       agents_c = conflict.details{c(end)}(:,1);
       % for each agent create a fork and a bottle
       for a = 1:length(agents_c)
           agent2_id = agents_c(a);
           if agent1_id < agent2_id
               bottles_table{agent1_id, agent2_id, conflict_cell} = bottle_id;
               % obj = bottle(id, sharedWith, holding, req, need, occupy)
               b = bottle(bottle_id, agents(agent2_id), 1, 0, 0, 0);
               bottle_id = bottle_id + 1; 
           else
               b = bottle(bottles_table{agent2_id, agent1_id, conflict_cell}, agents(agent2_id), 0, 1, 0, 0);
           end
           b.setCellId(conflict_cell);
           bottles{n} = [bottles{n} b];
           %agents(n).addBottles(b);
       end
   end
end

% add forks
forks_table = cell(N,N);
forks_id = 1;
forks = cell(N,1);
for n = 1:N
    %agent1 = agents(n);
    agent1_id = n;
    conflicting_agents = zeros(1,length(bottles{n}));
    for b = 1:length(bottles{n})
        conflicting_agents(b) = bottles{n}(b).sharedWith.id;
    end
    conflicting_agents = unique(conflicting_agents);
    for c = 1:length(conflicting_agents)
        agent2_id = conflicting_agents(c);
        if agent1_id < agent2_id
            % obj = fork(id, sharedWith, holding, req, dirty)
            forks_table{agent1_id, agent2_id} = forks_id;
            f = fork(forks_id, agents(conflicting_agents(c)), 1, 0, 1);
            forks_id = forks_id + 1;
        else
            f = fork(forks_table{agent2_id, agent1_id}, agents(conflicting_agents(c)), 0, 1, 0);
        end
        forks{agent1_id} = [forks{agent1_id} f];
        %agent1.addForks(f);
    end
end

Sessions = cell(1,N);
% now find drinking sessions
for n = 1:N
    if n==5
        1;
    end
    sessions = {};
    agent_n = agents(n);
    session = [];
    for i = 1:length(paths{n})
       if conflicts{n}.bool(i)
           % find AssociatedBottles with corresponding cell
          associatedBottles = [];
          for b = 1:length(bottles{n})
              if bottles{n}(b).cellId == paths{n}(i)
                  associatedBottles = [associatedBottles bottles{n}(b).id];
              end
          end
           session = [session associatedBottles];
           if i == length(paths{n}) && ~isempty(session)
              sessions{end+1} = session;
              session = [];
           end
       else
           if isempty(session)
               continue
           else
               sessions{end+1} = session;
               session = [];
           end
       end
    end
    % agent_n.sessions = sessions;
    Sessions{n} = sessions;
end

for n = 1:N
   agents(n).bottles = bottles{n};
end
