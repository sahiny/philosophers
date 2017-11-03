classdef fork < matlab.mixin.Copyable
   properties
      id
      sharedWith
      holding
      req
      dirty
   end
   methods
       function obj = fork(id, sharedWith, holding, req, dirty)
           if nargin > 0
               obj.id = id;
               obj.sharedWith = sharedWith;
               obj.holding = holding;
               obj.req = req;
               obj.dirty = dirty;
           end
       end
       function setId(obj, id)
          obj.id = id;
       end
       function id = getId(obj)
          id = obj.id;
       end
       function setSharedWith(obj, sharedWith)
           obj.sharedWith = sharedWith;
       end
       function sharedWith = getSharedWith(obj)
           sharedWith = obj.sharedWith;
       end
       function setHolding(obj)
           obj.holding = 1;
       end
       function resetHolding(obj)
           obj.holding = 0;
       end
       function holding = getHolding(obj)
           holding = obj.holding;
       end
       function setDirty(obj)
           obj.dirty = 1;
       end
       function resetDirty(obj)
           obj.dirty = 0;
       end
       function need = getDirty(obj)
           need = obj.dirty;
       end
       function setReq(obj)
           obj.req = 1;
       end
       function resetReq(obj)
           obj.req = 0;
       end
       function req = getReq(obj)
           req = obj.req;
       end
   end
end