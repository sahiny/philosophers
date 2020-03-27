function sendFinalClearedSignal(obj)
% the cell that is cleared
id_cell_cleared = obj.path(obj.curr_pos_idx - 1);
% check if it appears later in the path
idx = find(obj.path == id_cell_cleared);
if any(idx > obj.curr_pos_idx - 1)
    return % don't sent signal if it appears later
end
% otherwise
B = obj.getCellBottles(id_cell_cleared);
for b = B
    a2 = b.sharedWith;
    if a2.path(end) == id_cell_cleared
        % send signal if id_cell_cleared is the last state of a2
        a2.final_location_cleared = a2.final_location_cleared + 1;
    end
end