function Bottles = find_rainbow_cycles_merge(obj, idx_next_state)

Bottles = [];

is_shared = find_shared_status(obj.Paths);
if ~is_shared(obj.path(idx_next_state)) || idx_next_state == length(obj.path)
    return
elseif ~is_shared(obj.path(idx_next_state+1))
    return
end

N = length(obj.Paths);
Cycles = find_rainbow_cycles_merge_helper(obj, idx_next_state, obj.path(idx_next_state), 1:N);

for c = 1:length(Cycles)
    my_cycle = Cycles(c);
    cycle_color = my_cycle.id_agents;
%     if any(cycle_color == obj.id)
        for i = 1:length(my_cycle.id_cells)
            for j = 1:N
                b1 = obj.getBottleId(my_cycle.id_cells(i), j);
    %             b2 = obj.getBottleId(my_cycle.id_cells(i), cycle_color(j));
                Bottles = [Bottles, b1];
            end
        end
%     end
end

Bottles = unique(Bottles);
%%%%%% new idea %%%%%%
if idx_next_state > 1 && obj.is_shared(idx_next_state)
    bottles_from_prev = setdiff(obj.sessions{idx_next_state - 1}, find(obj.bottle_cells == obj.path(idx_next_state-1)));
    Bottles = unique([Bottles, bottles_from_prev]);
end