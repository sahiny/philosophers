function tryDrinking(obj)
   if ~(strcmp(obj.drinkingState, 'thirsty') ||...
           strcmp(obj.drinkingState, 'insatiable') )
       return;
   end
   for b = obj.bottles
       if b.need && ~b.hold
           return;
       end
   end
   obj.startDrinking();
end