function colors = get_edge_colors(Paths, walk, c1)
% returns edge colors for a given closed walk where c1 is the first edge
% color

colors = cell(length(walk)-1,1);
% colors{1} = c1;

for i = 1:length(walk)-1
    wi = walk(i);
    wp = walk(i+1);

    for p = 1:length(Paths)
        wi_index = find(Paths{p}==wi);
        wp_index = wi_index + 1;
        wp_index = wp_index(wp_index <= length(Paths{p}));
        if any(Paths{p}(wp_index)== wp)
            colors{i} = [colors{i} p];
        end
    end

end
