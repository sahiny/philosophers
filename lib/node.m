classdef node < matlab.mixin.Copyable
   properties
      id_cell % unique id of the cell
      parent = [];
      ancestor_cells = [];
      children = [];
      children_id_cell;
      children_id_node;
      parent_colors = [];
      num_colors = 0;
      id;
   end
   methods
       function obj = node(id_cell, parent, parent_colors, ancestor_cells, num_colors)
           obj.id_cell = id_cell;
           obj.parent = parent;
           obj.parent_colors = parent_colors;
           obj.ancestor_cells = ancestor_cells;
           obj.num_colors = num_colors;
       end
       function colors = colors_left(obj)
           colors = setdiff(1:obj.num_colors, obj.parent_colors);
       end
   end
end