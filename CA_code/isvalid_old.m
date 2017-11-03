function [isvalid, option1, option2] = isvalid(Plan) 
isvalid = 1;
option1 = [];
option2 = [];
N = length(Plan.paths);
% Plan = struct();
% Plan.paths = paths;
% Plan.conflicts = conflicts;
% Plan.bottles = bottles;
% Plan.forks = forks;
% Plan.Sessions = Sessions;
% Plan.constraints = constraints;
% Plan.length = tdistance;
% Plan.agents = agents;
for n = 1:N
    if Plan.conflicts{n}.bool(1) == 0
        continue
    end
    session1 = Plan.Sessions{n}{1};
    for m = 1:N
       if m == n || Plan.conflicts{m}.bool(1) == 0
           continue
       end
       
       session2 = Plan.Sessions{m}{1};
       C = intersect(session1, session2);
       if isempty(C)
           continue
       else
           isvalid = 0;
           if ~isempty(find(Plan.paths{n} == Plan.paths{m}(1),1))
               option1 = [n, Plan.paths{m}(1)];
               if ~isempty(find(Plan.paths{m} == Plan.paths{n}(1),1))
                   option2 = [m, Plan.paths{n}(1)];
               end
               return
           end
           
       end
   end
end
end