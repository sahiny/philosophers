function findDrinkingSessions(obj, cycle_method)
% finds drinking sessions for each state
for i = 1:length(obj.path)
    disp(['Finding drinking session ', num2str(i),' for Agent', num2str(obj.id)])
    obj.sessions{i} = find_session_w_options(obj, i, cycle_method);
end