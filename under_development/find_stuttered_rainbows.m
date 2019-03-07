function SR_Bottles = find_stuttered_rainbows(obj, idx_state)
     SR_Bottles = [];
     if idx_state >= length(obj.path)
         return
     end
     root_node = obj.path(idx_state);
     root_edge = [obj.path(idx_state) obj.id obj.path(idx_state+1)];
     Cycles = find_all_cycles(obj, idx_state);
     Edges = find_colored_edges(Cycles, obj.Paths);
     SR_Edges = find_stuttered_rainbow_edges(Edges, root_node, root_edge, true);
     SR_Bottles = get_SR_Bottles(obj,SR_Edges);
end