function set_initial_conditions(Agents)
% check for initial session conflicts
for a = 1:length(Agents)
    % check if initial session includes an initial state
    if Agents{a}.is_shared(1)
        initial_session = Agents{a}.sessions{1};
        for b = 1:length(initial_session)
            bottle_b = Agents{a}.bottles(initial_session(b));
            a2 = bottle_b.sharedWith;
            if bottle_b.id_cell == a2.path(1)
                disp(['Conflict between Agent', num2str(a), ' and Agent', num2str(a2.id)]);
            end
        end
        %%%%%%%%%%% new idea %%%%%%%%%
        initial_session = find(Agents{a}.bottle_cells == Agents{a}.path(1));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Agents{a}.becomeThirsty(initial_session); %#ok<FNDSB>
        if strcmp(Agents{a}.drinkingState, 'drinking')
            if ~isempty(Agents{a}.sessions{2})
                Agents{a}.becomeInsatiable(Agents{a}.sessions{2});
            end
        else
            disp(['!!!!!!! Initial Condition Conflict (Agent', num2str(a),')']);
            assert(1==0);
        end
    end
end