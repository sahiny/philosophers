function move_philosopher(obj)
if obj.curr_pos_idx == length(obj.path)
    return
end

if obj.id == 32
    1;
end

obj.move_completed = false;
% figure out what bottles are needed
obj.curr_session = obj.sessions{obj.curr_pos_idx};

obj.next_session = obj.sessions{obj.curr_pos_idx+1};

% if the last state is not cleared, do nothing
if obj.is_final_location_included() && ...
        sum(obj.final_location_cleared) < length(obj.getCellBottles(obj.path(end)))
    return
end
% if thirsty and the next state is contested, become thirsty
if ~isempty(obj.next_session) && strcmp(obj.drinkingState, 'tranquil')
        obj.becomeThirsty(obj.next_session);
end

try_moving(obj);

    