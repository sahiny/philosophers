function bottles = get_cycle_bottles(obj, cycle, edge_colors)
bottles = [];

for s = 1:length(cycle)-1
    id_cell = cycle(s);
    s_colors = edge_colors{s};
    for c = 1:length(s_colors)
        b1 = obj.getBottleId(id_cell, s_colors(c));
        b2 = obj.getBottleId(cycle(s+1), s_colors(c));
        bottles = unique([bottles b1 b2]);
    end
end


        