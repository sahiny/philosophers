function startDrinking(obj)
   % R2 of Ginat et al.
   if ~(strcmp(obj.drinkingState, 'thirsty') || strcmp(obj.drinkingState, 'insatiable'))
       disp('must be thirsty or insatiable before drinking');
   end
   for b = obj.bottles
       if b.need && ~b.hold
           disp(['Bottle (', num2str(b.cellId)])
           disp('cannot start drinking before all needed bottles acquired');
           return;
       end
   end
   if obj.id == 16
       1;
   end
   obj.drinkingState = 'drinking';
end