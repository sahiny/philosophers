function b = curr_session_bottles(obj)
b = [obj.bottle_cells(obj.sessions{obj.curr_pos_idx});
     obj.bottle_sharedWith(obj.sessions{obj.curr_pos_idx})];