function receiveBottle(obj, b)
   % R6 of Ginat et al.
   b = obj.getBottle(b.id_cell, b.id_holder);
   b.hold = true;
   obj.tryDrinking();
%    obj.try_moving();
   obj.msgReceived = obj.msgReceived + 1;
end