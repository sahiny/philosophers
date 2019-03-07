function SR_Edges = find_stuttered_rainbow_edges(Edges, root_node, root_edge, is_root_edge_forced)
SR_Edges = [];
if isempty(Edges)
    return
end
open_list = {};
closed_list = [];
% is_root_edge_forced = 1, find cycles that starts with agents's own color
if is_root_edge_forced
    open_list = {[root_edge]};
else
    open_list = {};
    V2 = find(Edges(:,1) == root_node);
    for i = 1:length(V2)
        open_list{end+1} = Edges(V2(i),:);
    end
end

while ~isempty(open_list)
    % pick a candidate run
    current_run = open_list{end}; open_list(end) = []; 
    closed_list = [closed_list; ]
    % last node of this run
    v1 = current_run(end);
    % find possible transitions from v1
    V2 = find(Edges(:,1) == v1);
    
    % something to eliminate options from V2
    1;
    
    % check if this lead is worth to explore (can be a stuttered rainbow)
    for i = 1:length(V2)
        this_edge = Edges(V2(i),:);
        new_run = [current_run; this_edge];
        if size(unique(new_run, 'rows', 'stable'),1) == size(current_run,1)
            % repeated edge
            continue;
        end
                
        % if this_color is stuttering of the last or a new color, explore
        if this_edge(2) == current_run(end,2) ...
                || isempty(find(current_run(end,2) == this_edge(2),1))
            
            if this_edge(3) == root_node
                SR_Edges = unique([SR_Edges;current_run;this_edge], 'rows', 'stable');
            else
                open_list{end+1} = new_run;
            end
        end
    end 
end

    