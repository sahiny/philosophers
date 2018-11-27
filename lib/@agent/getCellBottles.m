function B = getCellBottles(obj, id_cell)
    B = [];
    for id_agent = 1:length(obj.Paths)
        B = [B obj.getBottle(id_cell, id_agent)];
    end
end