function receiveRequest(obj, id_cell, s_num, id_sender)
   % R5 of Ginat et al.
   b = obj.getBottle(id_cell, id_sender);
   b.req = true;
   obj.max_rec = max(obj.max_rec, s_num);  
   %%%% DEBUG %%%%%%%%%%
   a2 = b.sharedWith;
   if obj.id == 26 && a2.id == 31
       1;
   end
   if obj.id == 26 && a2.id == 31
       1;
   end
   %%%%%%%%%%%%%%%%
   if ~b.need
       b.hold = false;
       a2 = b.sharedWith;
       a2.receiveBottle(b);
   elseif (strcmp(obj.drinkingState, 'thirsty')&&...
    (s_num <  obj.s_num || (s_num == obj.s_num && id_sender < obj.id)|| strcmp(a2.drinkingState, 'insatiable')))
       b.hold = false;
       a2 = b.sharedWith;
       a2.receiveBottle(b);
   elseif strcmp(obj.drinkingState, 'insatiable') && isempty(find(obj.sessions{obj.curr_pos_idx}==b.id,1))&&...
    (s_num <  obj.s_num || (s_num == obj.s_num && id_sender < obj.id)) && ~strcmp(a2.drinkingState, 'thirsty')
       b.hold = false;
       a2 = b.sharedWith;
       a2.receiveBottle(b);
   end
   if b.need && ~b.hold && b.req
       a2 = b.sharedWith;
       a2.receiveRequest(b.id_cell, obj.s_num, obj.id);
   end
   obj.msgReceived = obj.msgReceived + 1;

end