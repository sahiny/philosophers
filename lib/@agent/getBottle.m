function b = getBottle(obj, id_cell, id_sharedWith)
    % find the index of the bottle
    id = getBottleId(obj, id_cell, id_sharedWith);
    
    if ~isempty(id)
        b = obj.bottles(id);
    else
        b = [];
    end

end