function requestBottle(obj,b)
   % R4 of Ginat et al.
   if ~(b.need && ~b.hold && b.req)
       disp('need, ~hold, req');
   end
   %req_bottle
   b.req = false;
   a2 = b.sharedWith;
   a2.receiveRequest(b.id_cell, obj.s_num, obj.id);
   obj.msgSent = obj.msgSent + 1;
end