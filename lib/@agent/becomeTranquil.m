function becomeTranquil(obj)
   % R3 of Ginat et al.
   if ~strcmp(obj.drinkingState, 'drinking')
       disp('must be drinking before becoming tranquil');
   end
   obj.drinkingState = 'tranquil';
   for b = obj.bottles
       if b.need
           b.need = false;
       end
       if b.req && b.hold
           b.hold = false;
           a2 = b.sharedWith;
           a2.receiveBottle(b);
       end
   end
end