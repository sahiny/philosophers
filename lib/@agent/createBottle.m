function createBottle(obj, id_cell, sharedWith)
    % create bottle
    b = bottle(length(obj.bottles)+1, obj.id, id_cell, sharedWith);
    % add bottle to agent's inventory
    obj.bottles = [obj.bottles b];
    % keep an index to find it later
    idx = length(obj.bottles);
    obj.bottle_cells(idx) = id_cell;
    obj.bottle_sharedWith(idx) = sharedWith.id;
end