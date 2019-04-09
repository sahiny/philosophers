function b = next_session_bottles(obj)
b = [obj.bottle_cells(obj.sessions{obj.curr_pos_idx+1});
     obj.bottle_sharedWith(obj.sessions{obj.curr_pos_idx+1})];