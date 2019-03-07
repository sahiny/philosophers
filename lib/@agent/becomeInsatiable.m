function becomeInsatiable(obj, bottles)

   % R7 additional rule to Ginat et al.
   if isempty(bottles)
       return
   end
   if ~strcmp(obj.drinkingState, 'drinking')
       disp('must be drinking before becoming insatiable');
   end
   obj.drinkingState = 'insatiable';
   % request new bottles
   for i = bottles
       b = obj.bottles(i);
       b.need = true;
   end
   for i = bottles
       b = obj.bottles(i);
       if b.need && ~b.hold && b.req
           obj.requestBottle(b);
       end
   end
   % drop bottles no longer needed
   if obj.curr_pos_idx > 1
       bottles_not_needed = setdiff(obj.sessions{obj.curr_pos_idx - 1}, obj.sessions{obj.curr_pos_idx});
       for i = 1:length(bottles_not_needed)
           b = obj.bottles(bottles_not_needed(i));
           if b.id_cell == 557 && obj.id ==7
               1;
           end
           b.need = false;
           if b.hold && b.req
               b.hold = false;
               a2 = b.sharedWith;
               a2.receiveBottle(b);
           end
   end
   end
   obj.tryDrinking();
end