function bool = is_final_location_included(obj)
bool = true;
for i = obj.curr_pos_idx+1:length(obj.path)
    B = getCellBottles(obj, obj.path(i));
    if isempty(B)
        bool = false;
        return
    end
end