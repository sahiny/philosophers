function is_shared = find_shared_status(Paths)
% returns a boolean vector where is_shared(id_cell) = true
% if id_cell is a shared state

% find the min length of the vector
max_id = 0;
for p = 1:length(Paths)
    max_id = max(max_id, max(Paths{p}));
end

is_shared = zeros(max_id,1);

for p = 1:length(Paths)
    is_shared(Paths{p}) = is_shared(Paths{p}) + 1;
end 

is_shared = is_shared > 1;