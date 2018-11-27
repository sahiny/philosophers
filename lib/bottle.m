classdef bottle < matlab.mixin.Copyable
   properties
      id
      id_holder
      id_cell
      sharedWith
      hold = false;
      req = false;
      need = false;
   end
   methods
       function obj = bottle(id_bottle, id_holder, id_cell, sharedWith)
           obj.id = id_bottle;
           obj.id_holder = id_holder;
           obj.id_cell = id_cell;
           obj.sharedWith = sharedWith;
           if obj.id_holder < sharedWith.id
               obj.hold = true;
           else
               obj.req = true;
           end
       end
   end
end