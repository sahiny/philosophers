function SR_Bottles = get_SR_Bottles(obj,SR_Edges)
SR_Bottles =  [];

for s = 1:size(SR_Edges,1)
    b = obj.getBottleId(SR_Edges(s,1), SR_Edges(s,2));
%     b2 = obj.getBottleId(SR_Edges(3), SR_Edges(2));
    SR_Bottles = [SR_Bottles b];
end

SR_Bottles = unique(SR_Bottles);