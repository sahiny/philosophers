function receiveRequest(obj, id_cell, s_num, id_sender)
   % R5 of Ginat et al.
   b = obj.getBottle(id_cell, id_sender);
   b.req = true;
   obj.max_rec = max(obj.max_rec, s_num);   
   if ~b.need || ...
    (strcmp(obj.drinkingState, 'thirsty') &&...
    (s_num <  obj.s_num || (s_num == obj.s_num && id_sender < obj.id)))
       b.hold = false;
       a2 = b.sharedWith;
       a2.receiveBottle(b);
   end
   obj.msgReceived = obj.msgReceived + 1;
end