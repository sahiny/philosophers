function E = find_colored_edges(Cycles, Paths)
E = [];

for c = 1:length(Cycles)
    mycycle = Cycles{c};
    for v = 1:length(mycycle)-1
        v1 = mycycle(v);
        v2 = mycycle(v+1);
        % find all colors for this edge
        colors_v1v2 = [];
        for p = 1:length(Paths)
            v1_indices = Paths{p}==v1;
            v2_indices = [false v1_indices(1:end-1)];
            if any(Paths{p}(v2_indices)== v2)
                colors_v1v2 = [colors_v1v2; p];
            end
        end
        e = [repmat(v1, size(colors_v1v2)) colors_v1v2 repmat(v2, size(colors_v1v2))];
        E = [E; e];
    end
end