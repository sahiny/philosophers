function longSessions = findLongSessions(Plan, session_threshold) 

longSessions = struct();
sessions = [];

N = length(Plan.paths);

longestSessionId = 1;
maxBottleId = 1;
maxBottle = 0;
maxLength = 0;

avgBottle = 0;
avgLength = 0;
ascBottlesNumber = {};
% find drinking sessions longer than threshold
for n = 1:N    
    for m = 1:length(Plan.Sessions{n})
        if length(Plan.Sessions{n}{m}) >= session_threshold
            longSession = struct();
            longSession.agentId = n;
            longSession.sessionId = m;
            longSession.nBottles = length(Plan.Sessions{n}{m});
            % find asssociated Bottles
            longSession.ascBottles = Plan.Sessions{n}{m};
            % find asssociated Cells
            associatedCells = [];
           for b = 1:length(Plan.Sessions{n}{m})
              mybottle = Plan.agents(n).getBottle(Plan.Sessions{n}{m}(b));
              associatedCells = [associatedCells, mybottle.cellId]; 
           end
           longSession.ascCells = unique(associatedCells);
           longSession.ascBottleNumber = zeros(length(longSession.ascCells),1);
           for c = 1:length(longSession.ascCells)
              longSession.ascBottleNumber(c) =  ...
                  length(Plan.agents(n).getAssociatedBottles(longSession.ascCells(c))); 
           end
           % starting Local Time of long Session
           startTime = length(Plan.paths{n});
           % ending Local Time of Long Session
           endTime = 1;
           for a = 1:length(longSession.ascCells)
              if find(Plan.paths{n} == longSession.ascCells(a) ) <...
                      startTime
                  startTime = find(Plan.paths{n} == longSession.ascCells(a));
              end
              if find(Plan.paths{n} == longSession.ascCells(a))>...
                      endTime
                  endTime = find(Plan.paths{n} == longSession.ascCells(a));
              end
           end
           longSession.startTime = startTime;
           longSession.endTime = endTime;
           longSession.length = endTime-startTime+1;
           
           avgBottle = avgBottle + longSession.nBottles;
           avgLength = avgLength + longSession.length;
           
           longSession.ascCells = Plan.paths{n}(startTime:endTime);
           sessions = [sessions, longSession];
           if longSession.length > maxLength
                maxLength = endTime-startTime+1;
                longestSessionId = length(sessions);
           end
            if longSession.nBottles > maxBottle
                maxBottle = longSession.nBottles;
                maxBottleId = length(sessions);
            end
        end
    end
end

longSessions.sessions = sessions;
longSessions.count = length(sessions);
longSessions.avgBottle = avgBottle/length(sessions);
longSessions.avgLength = avgLength/length(sessions);
longSessions.longestSessionId = longestSessionId;
longSessions.maxBottleId = maxBottleId;

if isempty(sessions)
    longSessions = [];
end
