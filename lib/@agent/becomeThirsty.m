function becomeThirsty(obj, bottles)
   % R1 of Ginat et al.
   if isempty(bottles)
       return
   end
   if ~strcmp(obj.drinkingState, 'tranquil')
       disp('must be tranquil to become thirsty');
   end
   obj.drinkingState = 'thirsty';
   obj.s_num = obj.max_rec + 1;
   for i = 1:length(bottles)
       b = obj.getBottle(bottles(i).id_cell, bottles(i).sharedWith.id);
       b.need = true;
   end
   for i = 1:length(obj.bottles)
       b = obj.bottles(i);
       if b.need && ~b.hold && b.req
           obj.requestBottle(b);
       end
   end
   obj.tryDrinking();
end