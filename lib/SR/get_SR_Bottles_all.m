function SR_Bottles = get_SR_Bottles_all(obj, SR_Cycle)

SR_Bottles = [];
for i = 1:size(SR_Cycle,1)
    my_cycle = SR_Cycle{i,1};
    for c = 1:length(SR_Cycle{i,2})
        my_color = SR_Cycle{i,2}(c);
        for r = 1:size(my_cycle,1)-1
%             if my_cycle(r,c) == 1
                b1 = obj.getBottleId(SR_Cycle{i,3}(r), my_color);
                b2 = obj.getBottleId(SR_Cycle{i,3}(r+1), my_color);
                SR_Bottles = [SR_Bottles, b1];
                SR_Bottles = [SR_Bottles, b2];
%             end
        end
    end
end
SR_Bottles = unique(SR_Bottles);