function b = getBottle(obj, id_cell, id_sharedWith)
    for b = obj.bottles
        if b.id_cell == id_cell && b.sharedWith.id == id_sharedWith
            return
        end
    end
    b = [];
end