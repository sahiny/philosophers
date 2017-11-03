classdef agent < matlab.mixin.Copyable
   properties
      id
      position
      localTime = 1;
      globalTime = 0;
      path = [];
      conflict
      sessions = {};
      session_id = 1;
      bottles = [];
      forks = [];
      robots = [];
      ComPts = [];
      maxGlobalTime = 1000;
      maxMessages = 2000;
      messageReceived = 0;
      diningState = 'thinking';
      drinkingState = 'tranquil';
   end
   events
%       reqForkReceived
%       forkReceived
% %       reqBottleReceived
%       bottleReceived
%       gotHungry
%       finishedEating
   end
   methods (Access = protected)  
       function cp = copyElement(obj)
         % Shallow copy object
         cp = copyElement@matlab.mixin.Copyable(obj);
         % Get handle from Prop2
         oldBottles = obj.bottles;
         if ~isempty(oldBottles)
             % Create default object
             copyBottles = eval(class(oldBottles));
             % Add public property values from orig object
             agent.propValues(copyBottles,oldBottles);
             % Assign the new object to property
             cp.bottles  = copyBottles;
         else
             cp.bottles = [];
         end
         % Get handle from Prop2
         oldForks = obj.forks;
         if ~isempty(oldForks)
             % Create default object
             copyForks = eval(class(oldForks));
             % Add public property values from orig object
             agent.propValues(copyForks,oldForks);
             % Assign the new object to property
             cp.forks  = copyForks;
         else
             cp.forks = [];
         end
       end
   end
   methods (Static)
        function propValues(newObj,orgObj)
             pl = properties(orgObj);
             for k = 1:length(pl)
                if isprop(newObj,pl{k})
                   newObj.(pl{k}) = orgObj.(pl{k});
                end
             end
        end
   end
   methods
       function obj = agent(id)
           if nargin > 0
               obj.id = id;
           end
%            lReqForkReceived = obj.addlistener('reqForkReceived', @obj.respondReqForkReceived);
%            lReqForkReceived.Recursive = true;
%            lForkReceived = obj.addlistener('forkReceived', @obj.respondForkReceived);
%            lForkReceived.Recursive = true;
%            lReqForkReceived = obj.addlistener('reqBottleReceived', @obj.respondReqBottleReceived);
%            lReqForkReceived = obj.addlistener('bottleReceived', @obj.respondBottleReceived);
%            lReqForkReceived = obj.addlistener('gotHungry', @obj.respondGotHungry);
%            lReqForkReceived = obj.addlistener('finishedEating', @obj.respondFinishedEating);
       end
       % Make a copy of a handle object.
       function setId(obj, id)
          obj.id = id;
       end
       function id = getId(obj)
          id = obj.id;
       end
       function setPosition(obj, pos)
          obj.position = pos;
       end
       function pos = getPosition(obj)
          pos = obj.position;
       end
       function setLocalTime(obj, time)
          obj.localTime = time;
       end
       function id = getLocalTime(obj)
          id = obj.localTime;
       end
       function setPath(obj, mypath)
           obj.path = mypath;
       end
       function path = getPath(obj)
           path = obj.path;
       end
       function iState = getInitialState(obj)
           iState = obj.path(1);
       end
       function fState = getFinalState(obj)
           fState = obj.path(end);
       end
       function addRobots(obj, robots)
           obj.robots = robots;
       end
       function setSessions(obj, sessions)
           obj.sessions = sessions;
       end
       function sessions = getSessions(obj)
           sessions = obj.sessions;
       end
       function current_session = getCurrentSession(obj)
           current_session = obj.sessions{obj.localTime};
       end
       function next_session = getNextSession(obj)
           if obj.localTime < length(obj.sessions)
               next_session = obj.sessions{obj.localTime+1};
           else
               next_session = [];
           end
       end
       function bool = move(obj, prob)
           if obj.id == 6
               1;
           end
           % if no conflict, moves the agent with prob probability
           % if there is a conflict goes thirsty               
           if obj.localTime == length(obj.path)
               bool = 1;
               return
           end
           % if it's first step, let conflicting initial states start
           if obj.globalTime == 0
               if obj.conflict.bool(1)
                   obj.getThirsty(obj.sessions{obj.session_id});
               end
               bool = obj.localTime == length(obj.path);
               obj.globalTime = 1;
               return;
           end
           % if it's not the first step, then check before moving
           if obj.conflict.bool(obj.localTime + 1) 
               % if in conflict, get bottles first
               if obj.isTranquil()
                   if obj.id ==5 && obj.localTime ==4
                   1;
                   end
                   obj.getThirsty(obj.sessions{obj.session_id});
               end
               % create conflict, solve conflict
               if obj.isDrinking() && rand(1) < prob
                  % if no conflict, moves the agent with prob probability
                  obj.localTime = obj.localTime + 1;
                  % release the bottle (be more careful)
                  associatedBottles = obj.getAssociatedBottles(obj.position);
                  obj.position = obj.path(obj.localTime);
                  for b = 1:length(associatedBottles)
                     usedbottle = obj.getBottle(associatedBottles(b));
                     usedbottle.need = 0;
                     obj.sendBottle(usedbottle.id);
%                      agent2 = usedbottle.sharedWith;
%                      if agent2.id < obj.id
%                         agent2.move(prob);
%                      end
                  end
               end
           else
               % if not in conflict, move
               if rand(1) < prob
                   obj.localTime = obj.localTime + 1;
                   obj.position = obj.path(obj.localTime);
                   % maybe end a drinking session
                   if obj.isDrinking()
                       obj.finishDrinking();
                       obj.session_id = obj.session_id + 1;
                   end
               end
           end
           % increase global time
           obj.globalTime = obj.globalTime + 1;
           if obj.globalTime > obj.maxGlobalTime
               assert(1, 'Took too long');
           end
           % check if arrived 
           bool = obj.localTime == length(obj.path);
       end
       %% Philosopher Related
       function bool = isThinking(obj)
           bool = strcmp(obj.diningState, 'thinking');
       end
       function bool = isHungry(obj)
           bool = strcmp(obj.diningState, 'hungry');
       end
       function bool = isEating(obj)
           bool = strcmp(obj.diningState, 'eating');
       end
       function bool = isTranquil(obj)
           bool = strcmp(obj.drinkingState, 'tranquil');
       end
       function bool = isThirsty(obj)
           bool = strcmp(obj.drinkingState, 'thirsty');
       end
       function bool = isDrinking(obj)
           bool = strcmp(obj.drinkingState, 'drinking');
       end
       %% Drinking Related
       function addBottles(obj, bottles)
           obj.bottles = [obj.bottles bottles];
       end
       function bottle = getBottle(obj,id)
           for b = 1:length(obj.bottles)
              if obj.bottles(b).id == id
                  bottle = obj.bottles(b);
              end
           end
       end
       function bottle_ids = getAllBottleIDs(obj)
           bottle_ids = zeros(1,length(obj.bottles));
           for b = 1:length(obj.bottles)
               bottle_ids(b) = obj.bottles(b).id;
           end
       end
       function bottleIds = getAssociatedBottles(obj, cellId)
          bottleIds = [];
          for b = 1:length(obj.bottles)
              if obj.bottles(b).cellId == cellId
                  bottleIds = [bottleIds obj.bottles(b).id];
              end
          end
       end
       function f = getAssociatedFork(obj, b)
           for i = 1:length(obj.forks)
               if obj.forks(i).sharedWith.id == b.sharedWith.id
                   f = obj.forks(i);
                   break;
               end
           end
       end
       function sendBottle(obj,id)
           b = obj.getBottle(id);
           agent2 = b.sharedWith;
           f = obj.getAssociatedFork(b);
           assert(f.sharedWith.id == agent2.id);
           if b.req==1 && b.holding==1 && ~(b.need==1 && (obj.isDrinking() || f.holding==1))
               b.holding = 0;
               agent2.receiveBottle(b.id);
               obj.sendBottleReq(id);
           end
       end
       function receiveBottle(obj,id)
           b = obj.getBottle(id);
           b.holding = 1;
           obj.messageReceived = obj.messageReceived + 1;
           if obj.messageReceived > obj.maxMessages
            assert(obj.messageReceived < obj.maxMessages, strcat('Agent', num2str(obj.id),' received too many messages'));
           end
            %            if b.req==1 && b.holding==1 &&...
%                    ~(b.need==1 && (obj.isDrinking() || f.holding==1))
               obj.sendBottle(b.id);
%            end
           if obj.isThirsty()
               obj.tryDrinking();
           end
       end
       function sendBottleReq(obj,id)
           b = obj.getBottle(id);
           if obj.isThirsty() && b.need==1 && b.req==1 && b.holding ==0
               agent2 = b.sharedWith;
               b.req = 0;
               agent2.receiveBottleReq(b.id);
           end
       end
       function receiveBottleReq(obj,id)
           b = obj.getBottle(id);
           b.req = 1;
           obj.messageReceived = obj.messageReceived + 1;
           assert(obj.messageReceived < obj.maxMessages, strcat('Agent', num2str(obj.id),' received too many messages'));
           obj.sendBottle(id);
       end
       function getThirsty(obj, ids)
           obj.drinkingState = 'thirsty';
           if obj.isThinking()
               obj.getHungry();
           end
           for b = 1:length(ids)
              obj.getBottle(ids(b)).need = 1; 
           end
           obj.tryDrinking();
           if ~obj.isDrinking()
               for b = 1:length(obj.bottles)
                   obj.sendBottleReq(obj.bottles(b).id);
               end
           end
       end
       function tryDrinking(obj)
           if ~obj.isThirsty()
           assert(obj.isThirsty() || obj.isDrinking(), ...
               strcat('Agent', num2str(obj.id), 'Wasnt thirsty before drinking'));
           end
           canDrink = 1;
           for b = 1:length(obj.bottles)
               if obj.bottles(b).need==1 && obj.bottles(b).holding==0
                   canDrink = 0;
                   break;
               end
           end
           if canDrink == 1
               obj.drinkingState = 'drinking';
               %disp(strcat('Agent', num2str(obj.id), ' started drinking'));
               if obj.isEating()
                  obj.finishEating();
               end
           end
       end
       function finishDrinking(obj)
           obj.drinkingState = 'tranquil';
           %disp(strcat('Agent', num2str(obj.id), ' finished drinking!'));
           for b = 1:length(obj.bottles)
               obj.bottles(b).need = 0;
               obj.sendBottle(obj.bottles(b).id);
           end
       end
       %% Dining Related
       function n = neighbors(obj)
           n = [];
           for f = 1:length(obj.forks)
               n = [n obj.forks(f).sharedWith.id];
           end
           n = unique(n);
       end
       function addForks(obj, forks)
           obj.forks = [obj.forks forks];
       end
       function forks = getAllForks(obj)
           forks = obj.forks;
       end
       function fork = getFork(obj,id)
           for f = 1:length(obj.forks)
              if obj.forks(f).id == id
                  fork = obj.forks(f);
              end
           end
       end
       function sendFork(obj,id)
           f = obj.getFork(id);
           if ~obj.isEating() && f.req == 1 && f.dirty == 1 && f.holding==1
               f.holding = 0;
               f.dirty = 0;
               agent2 = f.sharedWith;
               agent2.receiveFork(f.id);
               obj.sendForkReq(f.id);
           end
       end
       function receiveFork(obj,id)
           f = obj.getFork(id);
           assert(f.holding == 0, strcat('Agent', num2str(obj.id),' received a fork already holding'));
           f.holding = 1;
           f.dirty = 0;
           obj.messageReceived = obj.messageReceived + 1;
           assert(obj.messageReceived < obj.maxMessages, strcat('Agent', num2str(obj.id),' received too many messages'));
           obj.tryEating();
           for b = 1:length(obj.bottles)
               obj.sendBottle(obj.bottles(b).id);
           end
       end
       function sendForkReq(obj,id)
           f = obj.getFork(id);
           if obj.isHungry() && f.req == 1 && f.holding == 0
               agent2 = f.sharedWith;
               f.req = 0;
               agent2.receiveForkReq(f.id);
           else
               1;
%                assert(1==0, strcat('Agent', num2str(obj.id),...
%                    ' is not holding a token for fork', num2str(f.id),'!'));
           end
       end
       function receiveForkReq(obj,id)
           f = obj.getFork(id);
           f.req = 1;
           obj.messageReceived = obj.messageReceived + 1;
           assert(obj.messageReceived < obj.maxMessages, strcat('Agent', num2str(obj.id),' received too many messages'));
           if ~obj.isEating() && f.dirty && f.holding
               obj.sendFork(f.id);
           end
       end
       function getHungry(obj)
%            assert(obj.diningState == 'thinking');
           obj.diningState = 'hungry';
           %disp(strcat('Agent', num2str(obj.id), ' is hungry'));
           obj.tryEating();
           for f = 1:length(obj.forks)
              if obj.isHungry() && obj.forks(f).req && ~obj.forks(f).holding
                  obj.sendForkReq(obj.forks(f).id);
              end
           end
       end
       function tryEating(obj)
           canEat = 1;
           for f = 1:length(obj.forks)
               if obj.forks(f).holding == 0
                   canEat = 0;
                   break;
               end
           end
           if canEat == 1
               obj.diningState = 'eating';
               %disp(strcat('---Agent', num2str(obj.id), ' started eating.'));
           end
       end
       function finishEating(obj)
%            assert(obj.diningState == 'eating');
           if ~obj.isThirsty()
            obj.diningState = 'thinking';
           end
           %disp(strcat('....Agent', num2str(obj.id), ' is done eating!'));
           for i = 1:length(obj.forks)
               obj.forks(i).dirty = 1;
               obj.sendFork(obj.forks(i).id);
           end
%            notify(obj, 'finishedEating');
       end
   end
end