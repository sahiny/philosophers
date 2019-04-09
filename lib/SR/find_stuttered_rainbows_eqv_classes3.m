function SR_Bottles = find_stuttered_rainbows_eqv_classes3(obj, idx_state)
     SR_Bottles = [];
    is_shared = find_shared_status(obj.Paths);
    if idx_state >= length(obj.path) || ~is_shared(obj.path(idx_state))
        return
    end

    SR_Cycles = check_sr_cycle_eqv_class2(obj, idx_state, 0);
    SR_Bottles = get_SR_Bottles_all(obj, SR_Cycles);
    k = find_last_state_index(SR_Cycles, obj, idx_state);
    
    j = 2;
    while j <= k + 1 %&& is_shared(obj.path(idx_state + j)) && idx_state + j <= length(obj.path)
        SR_Cycles2 = check_sr_cycle_eqv_class_helper2(obj,idx_state, j);        
        j = j + 1;
        if isempty(SR_Cycles2)
            1;
        else
            SR_Cycles = SR_Cycles2;
            SR_Bottles = [SR_Bottles get_SR_Bottles_all(obj, SR_Cycles)];
            k = max(k, find_last_state_index(SR_Cycles, obj, idx_state));
        end
    end
    SR_Bottles = unique(SR_Bottles);
    %%%%%% new idea %%%%%%
    if idx_state > 1 && obj.is_shared(idx_state)
        bottles_from_prev = setdiff(obj.sessions{idx_state - 1}, find(obj.bottle_cells == obj.path(idx_state-1)));
        SR_Bottles = unique([SR_Bottles, bottles_from_prev]);
    end
end