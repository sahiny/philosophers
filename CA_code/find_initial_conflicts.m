function [conflicting_agent_ids, initials] = find_initial_conflicts(Plan)

N = length(Plan.agents);

conflicting_agent_ids = [];
initials = [];
for n = 1:N
    if Plan.conflicts{n}.bool(1)
        conflicting_agent_ids = [conflicting_agent_ids n];
        initials = [initials, Plan.paths{n}(1)];
    end
end