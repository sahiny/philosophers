function try_moving(obj)
% %%%%%% VIS PURPOSES %%%%%%
% global positions ws final_locations
% %%%%%% VIS PURPOSES %%%%%%
if obj.id == 32
        1;
end
% check if the move is allowed
is_move_allowed = strcmp(obj.drinkingState, 'drinking') || isempty(obj.next_session);

% move if the move is allowed
if is_move_allowed && ~obj.move_completed && rand(1) <= obj.prob_succ
    if obj.id == 32
        1;
    end
    obj.curr_pos_idx = obj.curr_pos_idx + 1;
    obj.sendFinalClearedSignal();
%     %%%%%% VIS PURPOSES %%%%%%
%     positions(obj.id) = obj.path(obj.curr_pos_idx);
%     plot_ws(ws, positions, final_locations, []);drawnow;
%     1;
%     %%%%%% VIS PURPOSES %%%%%%
    
    obj.move_completed = true;
    used_bottles = setdiff(obj.curr_session, obj.next_session);
    
    
    %         for i = 1:length(used_bottles)
%             b = used_bottles(i);
%             b.need = false;
%             if b.req && b.hold
%                b.hold = false;
%                a2 = b.sharedWith;
%                a2.receiveBottle(b);
%            end
%         end


    % update sessions
    obj.curr_session = obj.next_session;
    if obj.curr_pos_idx < length(obj.path)
        obj.next_session = obj.sessions{obj.curr_pos_idx + 1};
    else
        obj.curr_session = [];
    end
    
    % if the agent moved to a free state from a contested one, getTranquil
    if isempty(obj.curr_session) && strcmp(obj.drinkingState, 'drinking')
        obj.becomeTranquil();
    elseif strcmp(obj.drinkingState, 'tranquil')
        1;
    else
        if obj.curr_pos_idx <= length(obj.path)
            if ~isempty(obj.next_session)
                obj.becomeInsatiable(obj.next_session);
            end
        end
        % else get insatiable release the bottles no longer needed
%         obj.becomeInsatiable(obj.next_session);
%         for i = 1:length(used_bottles)
%             b = used_bottles(i);
%             b.need = false;
%             if b.req && b.hold
%                b.hold = false;
%                a2 = b.sharedWith;
%                a2.receiveBottle(b);
%            end
%         end
    end
end