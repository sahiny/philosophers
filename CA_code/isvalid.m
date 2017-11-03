function [isvalid, option1, option2] = isvalid2(Plan) 
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
       
       if ~isempty(intersect(Plan.paths{n}, Plan.paths{m}(end)))
           isvalid = 0;
           option1 = [n, Plan.paths{m}(end)];
           return
       end
       session2 = Plan.Sessions{m}{1};
       C = intersect(session1, session2);
       if isempty(C)
           continue
       else
           associatedCells1 = [];
           for b = 1:length(session1)
               mybottle = Plan.agents(n).getBottle(session1(b));
              associatedCells1 = [associatedCells1, mybottle.cellId]; 
           end
           associatedCells1 = unique(associatedCells1);
           initialBottle1 = Plan.agents(n).getAssociatedBottles(Plan.paths{n}(1));
           initialBottle1 = unique(initialBottle1);
           
           associatedCells2 = [];
           for b = 1:length(session2)
               mybottle = Plan.agents(m).getBottle(session2(b));
              associatedCells2 = [associatedCells2, mybottle.cellId]; 
           end
           associatedCells2 = unique(associatedCells2);
           initialBottle2 = Plan.agents(m).getAssociatedBottles(Plan.paths{m}(1));
           initialBottle2 = unique(initialBottle2);
           
           %isvalid = 0;
           found_conflict = 0;
           if ~isempty(intersect(associatedCells1, Plan.paths{m}(1)))
               option1 = [n, Plan.paths{m}(1)];
               found_conflict = 1;
           end
           if ~isempty(intersect(associatedCells2, Plan.paths{n}(1)))
                   option2 = [m, Plan.paths{n}(1)];
                   found_conflict = 1;
           end
           if found_conflict
               isvalid = 0;
               return
           end
           
       end
   end
end
end