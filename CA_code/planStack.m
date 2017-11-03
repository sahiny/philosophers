classdef planStack < handle
   properties
      %pushId = 1;
      contents = {};
      keys = [];
   end
   methods
       function obj = planStack()
           1;
       end
       function bool = isempty(obj)
          bool = isempty(obj.contents);
       end
       function push(obj, content, key)
          obj.contents{end+1} = content;
          obj.keys = [obj.keys key];
          %obj.pushId = obj.pushId + 1;
       end
       function [content, key] = pop(obj)
           if isempty(obj.contents)
               content = [];
               key = [];
           else
               [key, index] = min(obj.keys);
               index = index(end);
               obj.keys(index) = [];
               content = obj.contents{index};
               % delete the empty cell
               obj.contents{index} = [];
               obj.contents = obj.contents(~cellfun('isempty', obj.contents));
           end
       end
       function clear(obj)
           %obj.pushId = 1;
           obj.contents = {};
           obj.keys = [];
       end
       function delete(obj)
          %disp('Stack has been deleted');
          1;
       end
   end
end