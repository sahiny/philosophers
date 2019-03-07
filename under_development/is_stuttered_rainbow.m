function edge_colors2 = is_stuttered_rainbow(edge_colors)
open_list = {};
src = [];
for i = 1:length(edge_colors{1})
    first_node = struct();
    first_node.depth = 1;
    first_node.colors = edge_colors{1}(i);
    open_list{end+1} = first_node;
end

while ~isempty(open_list)
    current_node = open_list{end}; open_list(end) = [];
    current_depth = current_node.depth;
    
    for i = 1:length(edge_colors{current_depth+1})
        this_color = edge_colors{current_depth+1}(i);
        
        if this_color == current_node.colors(end) ...
                || isempty(find(current_node.colors == this_color,1))
            
            if current_depth+1 == length(edge_colors)
                src = [src [current_node.colors;this_color]];
            else
                next_node = struct();
                next_node.depth = current_depth+1;
                next_node.colors = [current_node.colors; this_color];
                open_list{end+1} = next_node;
            end
        end
    end 
end

if isempty(src)
    edge_colors2 = [];
else
    edge_colors2 = cell(size(edge_colors));
    for i = 1:length(edge_colors)
        edge_colors2{i} = unique(src(i,:));
    end
end
    