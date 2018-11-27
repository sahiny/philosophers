function sendFinalClearedSignal(obj)
id_cell_cleared = obj.path(obj.curr_pos_idx - 1);
B = obj.getCellBottles(id_cell_cleared);
for b = B
    a2 = b.sharedWith;
    if a2.path(end) == id_cell_cleared
        a2.final_location_cleared = a2.final_location_cleared + 1;
    end
end