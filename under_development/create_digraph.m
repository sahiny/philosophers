function G = create_digraph(Paths)
% find the max id_cell
max_id = 0;

for p = 1:length(Paths)
    max_id = max([max_id Paths{p}]);
end

I = [];
J = [];
V = [];
is_shared = [];

for p = 1:length(Paths)
    for l = 2:length(Paths{p})
        I = [I Paths{p}(l-1)];
        J = [J Paths{p}(l)];
        V = [V p];
        v = V(I==Paths{p}(l-1));
        if unique(v) > 1
            is_shared = [is_shared true];
            is_shared(I==Paths{p}(l-1)) = true;
        end
    end
end 

adj = sparse(I,J, ones(size(I)));

G = struct();
G.adj = adj;
G.I = I;
G.J = J;
G.V = V;


