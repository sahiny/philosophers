function id = getBottleId(obj, id_cell, id_sharedWith)
    % find bottles related to that cell
    b_id_cell = find(obj.bottle_cells == id_cell);
    % find bottles shared with that agent
    b_id_sharedWith = find(obj.bottle_sharedWith == id_sharedWith);
    % find the intersection (specific bottle we're looking for)
    id = intersect(b_id_cell, b_id_sharedWith);
end