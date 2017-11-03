classdef bottle < matlab.mixin.Copyable
   properties
      id
      sharedWith
      holding
      req
      need
      occupy
      cellId
   end
   methods
       function obj = bottle(id, sharedWith, holding, req, need, occupy)
           if nargin > 0
               obj.id = id;
               obj.sharedWith = sharedWith;
               obj.holding = holding;
               obj.req = req;
               obj.need = need;
               obj.occupy = occupy;
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
       function setNeed(obj)
           obj.need = 1;
       end
       function resetNeed(obj)
           obj.need = 0;
       end
       function need = getNeed(obj)
           need = obj.need;
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
       function setOccupy(obj)
           obj.occupy = 1;
       end
       function resetOccupy(obj)
           obj.occupy = 0;
       end
       function occupy = getOccupy(obj)
           occupy = obj.occupy;
       end
       function setCellId(obj, cellId)
           obj.cellId = cellId;
       end
   end
end