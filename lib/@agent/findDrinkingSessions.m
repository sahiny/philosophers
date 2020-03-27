function findDrinkingSessions(obj, cycle_method)
% finds drinking sessions for each state
disp(['Finding drinking sessions for Agent', num2str(obj.id)])
for i = 1:length(obj.path)
    %%%%%%%% DEBUG %%%%%%%%%%%
    if obj.id == 1 && i == 12
        1;
    end
    %%%%%%%% DEBUG %%%%%%%%%%%
    obj.sessions{i} = find_session_w_options(obj, i, cycle_method);
end