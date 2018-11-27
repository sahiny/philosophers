function createBottle(obj, id_cell, sharedWith)
    b = bottle(length(obj.bottles)+1, obj.id, id_cell, sharedWith);
    obj.bottles = [obj.bottles b];
end