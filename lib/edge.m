classdef edge < matlab.mixin.Copyable
   properties
      id_cell1 = [];
      color = [];
      id_cell2 = [];
      parent = [];
      ancestors = [];
      ancestor_cells = [];
      ancestor_colors = [];
      children = [];
   end
   methods
       function obj = edge(id_cell1, color, id_cell2, parent, ancestors, ancestor_colors, ancestor_cells)
           obj.id_cell1 = id_cell1;
           obj.id_cell2 = id_cell2;
           obj.color = color;
           obj.parent = parent;
           obj.ancestors = ancestors;
           obj.ancestor_colors = ancestor_colors;
           obj.ancestor_cells = ancestor_cells;
       end
   end
end