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
    %%%%%%%%%%%% debugging %%%%%%%%%%
           if obj.pos == 672 && obj.id == 33
               1;
           end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   if obj.curr_pos_idx > 1
       %%%%% Comment out the following line???
       bottles_not_needed = setdiff(obj.sessions{obj.curr_pos_idx - 1}, obj.sessions{obj.curr_pos_idx});
       %%%%%%%%% NEW IDEA %%%%%%%%%%%%
       old_states = setdiff(obj.path, obj.path(obj.curr_pos_idx:end));
       for os = old_states
            bottles_not_needed = [ bottles_not_needed, find(obj.bottle_cells == os)]; %#ok<AGROW>
       end
       bottles_not_needed = unique(bottles_not_needed);

       for i = 1:length(bottles_not_needed)
           b = obj.bottles(bottles_not_needed(i));
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEBUG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       if obj.id == 2 && b.id == 9
           1;
       end
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEBUG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
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