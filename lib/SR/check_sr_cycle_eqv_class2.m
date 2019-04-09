function sr_cycles = check_sr_cycle_eqv_class2(obj, idx_state, j)
%%% DEBUG %%%
if obj.id == 8 && idx_state == 10
    1;
end



% finds SR additions to all old_cycles
sr_cycles = {};
is_shared = find_shared_status(obj.Paths);
if idx_state + j >= length(obj.path) || ~is_shared(obj.path(idx_state + j))
    return
end

N = length(obj.Paths);

% find simple cycles containing this state
Cycles = find_cycle_combinations(obj, idx_state, j);

for c = 1:length(Cycles)
    my_cycle = Cycles{c};
    edge_classes = find_eq_classes(obj, my_cycle);

    open_list = {};

    for i = 1:N
        edge_i = edge_classes{i};
        if ~isempty(edge_i)
            if edge_i(1,1) == 1
                open_list{end+1,1} = edge_i(:,1);
                open_list{end,2} = i;
            end
        end
    end

    while ~isempty(open_list)
        % pick a candidate run
        current_run = open_list{end,1};
        current_colors = open_list{end,2};
        open_list(end,:) = []; 


        % last edge of this run
        e_last = current_run(:,end);
        i = find(e_last == 1, 1, 'first');
        j = find(e_last == 1, 1, 'last');

        % colors left 2 explore
        colors_left = setdiff(1:N, current_colors);

        for c = colors_left
            is_found = false;
            edges_c = edge_classes{c};
            for r = 1:size(edges_c,2)
                er = edges_c(:,r);
                er1 = find(er == 1, 1, 'first');
                er2 = find(er == 1, 1, 'last');
                if i <= er1 && er1 <= j && er2 >j
                    new_run = [current_run er];
                    new_colors = [current_colors c];
                    if er2 == length(my_cycle)
                        % found SR cycle
                        sr_cycles{end+1,1} = new_run;
                        sr_cycles{end,2} = new_colors;
                        sr_cycles{end,3} = my_cycle;
                        is_found = true;
                        break;
                    else
                        open_list{end+1,1} = new_run;
                        open_list{end,2} = new_colors;
                    end
                end
            end
            if is_found
                break
            end
        end
        
        % add all other edges that can go with this
        1;
        new_colors_added = is_found;
        while new_colors_added
            new_colors_added = false;
            % for all colors not included in this cycle
            colors_left = setdiff(1:N, sr_cycles{end,2});
            for c = colors_left
                % check for all super-edges with this color
                edges_c = edge_classes{c};
                for r = 1:size(edges_c,2)
                    er = edges_c(:,r);
                    er1 = find(er == 1, 1, 'first');
                    er2 = find(er == 1, 1, 'last');
                    % check if the super-edge is completely contained in some other
                    super_edges = sr_cycles{end,1};
                    for s = 1:size(super_edges,2)
                        % find indices of this edge
                        s1 = find(super_edges(:,s) == 1, 1, 'first');
                        s2 = find(super_edges(:,s) == 1, 1, 'last');
                        if s1 < er1 && er2 < s2
                            1;
                        else
                            new_colors_added = true;
                            sr_cycles{end,1} = [sr_cycles{end,1}, er];
                            sr_cycles{end,2} = [sr_cycles{end,2}, c];
                            break
                        end
                    end
                    1; % break
                end
            end
            
        end
        % done adding new colors
        if new_colors_added
            break
        end
    end
end
    
1;
    