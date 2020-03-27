function findDrinkingSessionsR2(Agents, Paths, version_number)
1;
find_rainbow_cycles_all(Agents, Paths, version_number)

% for a = 1:length(Agents)
%     for p = 1:length(Agents{a}.sessions)
%         bottle_id = Agents{a}.sessions{p};
%         bottle_cells = Agents{a}.bottle_cells(bottle_id);
%         remaining_path = Agents{a}.path(p:end);
%         future_bottles = zeros(size(bottle_cells));
%         for b = 1:length(future_bottles)
%             if isempty(find(remaining_path == bottle_cells(b)))
%                 future_bottles(b) = 1;
%             end
%         end
%         Agents{a}.sessions{p}(future_bottles) = [];
%     end
% end