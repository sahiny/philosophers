function startDrinking(obj)
   % R2 of Ginat et al.
   if ~strcmp(obj.drinkingState, 'thirsty')
       disp('must be thirsty before drinking');
   end
   for b = obj.bottles
       if b.need && ~b.hold
           disp(['Bottle (', num2str(b.cellId)])
           disp('cannot start drinking before all needed bottles acquired');
           return;
       end
   end
   obj.drinkingState = 'drinking';
end