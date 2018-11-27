function try_moving(obj)
% %%%%%% VIS PURPOSES %%%%%%
% global positions ws final_locations
% %%%%%% VIS PURPOSES %%%%%%


% check if the move is allowed
obj.next_session = find_next_session(obj, obj.curr_pos_idx+1);
is_move_allowed = true;
for i = 1:length(obj.next_session)
    if ~obj.next_session(i).hold
        is_move_allowed = false;
    end
end

% move if the move is allowed
if is_move_allowed && ~obj.move_completed && rand(1) <= obj.prob_succ
    obj.curr_pos_idx = obj.curr_pos_idx + 1;
    obj.sendFinalClearedSignal();
%     %%%%%% VIS PURPOSES %%%%%%
%     positions(obj.id) = obj.path(obj.curr_pos_idx);
%     plot_ws(ws, positions, final_locations, []);drawnow;
%     1;
%     %%%%%% VIS PURPOSES %%%%%%
    
    obj.move_completed = true;
    used_bottles = setdiff(obj.curr_session, obj.next_session);
    % update the current session
    obj.curr_session = obj.next_session;
    % if the agent moved to a free state from a contested one, getTranquil
    if isempty(obj.curr_session) && strcmp(obj.drinkingState, 'drinking')
        obj.becomeTranquil();
    else
        % else release the bottles no longer needed
        for i = 1:length(used_bottles)
            b = used_bottles(i);
            b.need = false;
            if b.req && b.hold
               b.hold = false;
               a2 = b.sharedWith;
               a2.receiveBottle(b);
           end
        end
    end
end