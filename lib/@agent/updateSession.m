function updateSession(obj)
% R7 added to Gina et al. by Yunus Sahin
    % set the need flags and request the bottles needed
    for i = 1:length(obj.next_session)
        b = obj.getBottle(obj.next_session(i).id_cell, obj.next_session(i).sharedWith.id);
        b.need = true;
    end
    for i = 1:length(obj.next_session)
        b = obj.next_session(i);
        if b.need && ~b.hold && b.req
           obj.requestBottle(b);
       end
    end
end