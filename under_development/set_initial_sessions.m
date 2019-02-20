function set_initial_sessions(Agents)
% find first sessions
for a = 1:length(Agents)
    Agents{a}.sessions{1} = find_session(Agents{a}, 1);
end
% check collision
for a = 1:length(Agents)
    % check if initial session includes initial state
    if Agents{a}.is_shared(1)
        initial_session = Agents{a}.sessions{1};
        for b = 1:length(initial_session)
            bottle_b = Agents{a}.bottles(initial_session(b));
            a2 = bottle_b.sharedWith;
            if bottle_b.id_cell == a2.path(1)
                disp('Conflict');
            end
        end
        Agents{a}.becomeThirsty(initial_session);
        if strcmp(Agents{a}.drinkingState, 'drinking')
            if ~isempty(Agents{a}.sessions{2})
                Agents{a}.becomeInsatiable(Agents{a}.sessions{2});
            end
        end
    end
end