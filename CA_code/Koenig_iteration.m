clear;close all;clc;

for n = 1:1
    if n == 7
        continue
    end
nExample = n;
maxSimNumber = 100;
rePlan_threshold = 1;

[totalTime, maxTime, totalDist, maxDist,finishTime, messages, nCollisions, succesfulCompletion, ...
    dummy_makespan, dummy_collisions, valids, heuristicValues] = Koenig(...
    nExample, maxSimNumber, rePlan_threshold);

% plot Heuristic things
% figure(1)
% clf
% hold on
% plot(1:rePlan_threshold, mean(makespan,1)/max(mean(makespan,1))', 'k')
% % plot(1:size(heuristicValues,1), heuristicValues(:,1)/max(heuristicValues(:,1)), 'b');
% % plot(1:rePlan_threshold, heuristicValues(:,2)/max(heuristicValues(:,2)), 'g');
% % plot(1:size(heuristicValues,1), heuristicValues(:,3)/max(heuristicValues(:,3)), 'r');
% plot(1:size(heuristicValues,1), heuristicValues(:,4)/max(heuristicValues(:,4)), 'm');
% 
% [R,P] = corrcoef([(mean(makespan,1)/max(mean(makespan,1)))'...
% %     heuristicValues(:,1)/max(heuristicValues(:,1)) ...
% %     heuristicValues(:,2)/max(heuristicValues(:,2)),...
% %     heuristicValues(:,3)/max(heuristicValues(:,3)),...
%     heuristicValues(:,4)/max(heuristicValues(:,4))]);
% x = [(mean(makespan,1)/max(mean(makespan,1)))' ,heuristicValues(:,4)/max(heuristicValues(:,4))];
% [R,P] = corrcoef(x);
save(strcat('Koenig_iteration_BadAgentHeuristic_wrong_prob_random', num2str(nExample)));
end