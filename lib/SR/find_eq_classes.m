function Edge_classes = find_eq_classes(obj, my_cycle)
% Given a simple monocolored cycle, groups the edges into eqv classes s.t
%       1. edges in the same group are of same color, and
%       2. edges are either 
%           (i)  consecutive or 
%           (ii) connected by edges belonging to the same class 


Paths = obj.Paths;
Edge_classes = cell(length(Paths),1);


% Edge_classes = cell(length(Cycles),length(Paths));
% for c = 1:length(Cycles)
%     my_cycle = Cycles{c};



    for p = 1:length(Paths)
        this_class = [];
        e = zeros(length(my_cycle),1);
        for v = 1:length(my_cycle)-1
            % (v1,v2) is an edge in monocolored path graph
            v1 = my_cycle(v);
            v2 = my_cycle(v+1);
            % check if agentP goes thru this edge
            v1_indices = Paths{p}==v1;
            v2_indices = [false v1_indices(1:end-1)];
            if any(Paths{p}(v2_indices)== v2)
                e(v:v+1) = 1;
            elseif any(e)
                this_class = [this_class e];
                e = zeros(length(my_cycle),1);
            end
        end
        if any(e)
            this_class = [this_class e];
        end
        if ~isempty(this_class)
            Edge_classes{p,1} = this_class;
        end
    end
% end