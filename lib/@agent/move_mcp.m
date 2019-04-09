function move_mcp(obj, Agents)
%% update knowledge on other agents' progress
for p = 1:length(obj.Paths)
    if obj.last_update_received(p) < obj.time
        obj.last_known_pos(p) = obj.last_known_pos_old(p);
    end
end

%% don't move if the final state is reached
if obj.curr_pos_idx == length(obj.path)
    return
end
%% otherwise see if you can move
obj.time_elapsed = obj.time_elapsed + 1;
N = length(obj.Paths);
curr_state = obj.pos;
next_state = obj.path(obj.curr_pos_idx + 1);

if obj.pos == next_state
    % if next_state is the same as the current, always move
    obj.curr_pos_idx = obj.curr_pos_idx + 1;
else
    % if not, see if agent has the right to move
    is_move_allowed = true;
    for p = setdiff(1:N, obj.id)
        % find time indices agentP visits the next state in the future
        next_state_order = find(obj.Paths{p} == next_state);
        idx = next_state_order >= obj.last_known_pos(p);
        next_state_order = next_state_order(idx);
        if ~isempty(next_state_order)
            if next_state_order(1) < obj.curr_pos_idx + 1
                is_move_allowed = false;
                break
            end
        end
    end
    % if agent is allowed to move, move with some probability
    if is_move_allowed && rand(1) <= obj.prob_succ
        obj.curr_pos_idx = obj.curr_pos_idx + 1;
        % send other agents messages
        for p = setdiff(1:N, obj.id)
            curr_state_order = find(obj.Paths{p}(obj.last_known_pos(p):end) == curr_state);
            if ~isempty(curr_state_order) && next_state ~= curr_state
%                 if curr_state_order(1) > obj.curr_pos_idx - 1
                    Agents{p}.last_known_pos_old(obj.id) = obj.curr_pos_idx;
                    Agents{p}.msgReceived = Agents{p}.msgReceived + 1; 
                    Agents{p}.last_update_received(obj.id) = obj.time;
%                 end
            end
        end
    end  
end

obj.time = obj.time + 1;