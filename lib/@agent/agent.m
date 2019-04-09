classdef agent < matlab.mixin.Copyable
   properties
      
      id % unique id for each agent
      path = []; % path that it needs to follow
      is_shared = []; % bool vector showing if the state in the path is shared
      curr_pos_idx = 1; % current pos given by agent.path(curr_pos_idx)
      time = 1; % global time
      Paths = {}; % paths of all agents
      prob_succ = 1; % success probability
      time_elapsed = 0;
      % drinking related
      drinkingState = 'tranquil';
      bottles = []; % inventory
      bottle_cells = []; % used for finding bottles
      bottle_sharedWith = []; % used for finding bottles
      sessions = {}; % sessions required for each state
      s_num = 0; % session number
      max_rec = 0; % max session number received
      curr_session = [];
      next_session = [];
      move_completed = true;
      final_location_cleared = 0;
      cycles = {};
      % MCP related
      last_known_pos = [];
      last_known_pos_old = [];
      last_update_received = [];
      % bookkeeping
      msgReceived = 0;
      msgSent = 0;
      maxTime = 1000; % stop simulation after this many time steps
      maxMessages = 20000; % stop simulation after this many messages
   end
   methods
       function obj = agent(varargin)
           obj.id = varargin{1};
           if nargin > 1
               obj.Paths = varargin{2};
               obj.prob_succ = varargin{3};
               obj.path = obj.Paths{obj.id};
               obj.cycles = cell(length(varargin{2}),1);
               obj.last_known_pos = ones(length(obj.Paths),1);
               obj.last_known_pos_old = ones(length(obj.Paths),1);
               obj.last_update_received = zeros(length(obj.Paths),1);
           end
       end
%        Conflicts = findConflicts(obj, Agents);
       
       %% Common
       id_cell = pos(obj);
       
       %% MCP
       move_mcp(obj, Agents);
       
       %% BOTTLE RELATED
       createBottle(obj, id_cell, sharedWith);
       createBottlesSharedWith(obj, agent2);
       b = getBottle(obj, id_cell, id_sharedWith);
       id = getBottleId(obj, id_cell, id_sharedWith);
       B = getCellBottles(obj, id_cell); 
       b = curr_session_bottles(obj);
       b = next_session_bottles(obj);
       %% DRINKING RELATED
       % Implements AN EFFICIENT SOLUTION TO THE DRINKING PHILOSOPHERS 
       % PROBLEM AND ITS EXTENSIONS by Ginat et al.
       becomeThirsty(obj, bottles);
       startDrinking(obj);
       becomeTranquil(obj);
       requestBottle(obj,b);
       receiveRequest(obj, id_cell, s_num, id_sender);
       receiveBottle(obj, b);
       tryDrinking(obj);
       becomeInsatiable(obj, bottles);
       %% Deadlock Avoidance related
       Cycles = find_rainbow_cycles_helper(obj, idx_next_state, root_color);
       Bottles = find_next_session(obj, idx_next_state);
       findDrinkingSessions(obj, Agents);
       move_philosopher(obj);
       try_moving(obj);
       bool = is_final_location_included(obj);
       sendFinalClearedSignal(obj);
       
   end
end