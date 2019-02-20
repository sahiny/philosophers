function move_old(obj)
obj.move_completed = false;
% figure out what bottles are needed
obj.next_session = find_next_session(obj, obj.curr_pos_idx+1);
if obj.is_final_location_included() && ...
        sum(obj.final_location_cleared) < length(obj.getCellBottles(obj.path(end)))
    return
end
% if the next state is contested, request required bottles
if ~isempty(obj.next_session) 
    % if the next state is contested
    if strcmp(obj.drinkingState, 'tranquil')
        % become thirsty if current state is free
        obj.becomeThirsty(obj.next_session);
    else
        % if already tranquil or moving, update the next session
        obj.updateSession();
    end
end

try_moving(obj);


    