function findDrinkingSessions(obj)
% finds drinking sessions for each state
for i = 2:length(obj.path)
    disp(['Finding drinking session for agent ', num2str(obj.id)])
    obj.sessions{i} = find_session(obj, i);
end