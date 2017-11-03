function conflicts = find_conflicts(paths)

N = length(paths);

conflicts = cell(N,1);

for n = 1:N
    % for each agent
    path_n = paths{n};
    conflict_n = struct();
    conflict_n.bool = zeros(1,length(path_n));
    % each cell [tn m tm]
    conflict_n.details = cell(1,length(path_n));
    for mm = 1:N-1
       % for each point visited 
       pn = path_n(p);
       % find conflicts
       others = setdiff(1:N,n);
       for mm = 1:length(path_n)
           m = others(mm);
           path_m = paths{m};
           if ~isempty(find(path_m == pn, 1))
              conflict_n.bool(p) = 1;
              conflict_n.details{p} = [conflict_n.details{p}; m find(path_m == pn, 1)];
           end
       end
    end
    conflicts{n} = conflict_n;
end