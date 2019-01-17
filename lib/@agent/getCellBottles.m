function B = getCellBottles(obj, id_cell)
    B = find(obj.bottle_cells == id_cell);
    B = obj.bottles(B);
end