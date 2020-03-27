function ws = create_workspace(numRows, numCols, obstacles)
% Creates a 5-connected grid workspace
% of size numRows x numCols with obstacles 
%
% INPUTS
% numRows: positive integer - Number of rows
% numCols: positive integer - Number of cols
% obstacles: column or row vector with obs indices (length < numRows*numCols)
%
% OUTPUT
% ws.adjn = Adjacency graph (obstacles are not removed and accesible)
% ws.adjr = Reduced adjacency graph (cols and rows that corr. to obs are deleted)
% ws.r2n = Maps the indices of adjr to adj
% ws.n2r = Maps the indices of adjr to adj

ws = struct();

% Create 5-connected grid ignoring obstacles
% adjn = eye(numRows*numCols);
% for i = 1:(numRows*numCols)
%     % right transitions
%     if i <= numRows*(numCols-1)
%         adjn(i,i + numRows) = 1;
%     end
%     
%     % left transitions
%     if i > numRows
%         adjn(i, i - numRows) = 1;
%     end
%     
%     % up transitions
%     if mod(i, numRows) ~= 1
%         adjn(i, i-1) = 1;
%     end
%     
%     % down transitions
%     if mod(i, numRows) ~= 0
%         adjn(i, i+1) = 1;
%     end
% end


% % Delete rows and cols that correpond to obstacles
% adjr = adjn;
% r2n = zeros(numRows*numCols - length(obstacles),1);
% n2r = zeros(numRows*numCols, 1);
% j=numRows*numCols - length(obstacles);
% for i = 1:(numRows*numCols)
%     isObs = ~isempty(find(obstacles==numRows*numCols+1-i,1));
%     if isObs
%         adjr(numRows*numCols+1-i,:) = [];
%         adjr(:,numRows*numCols+1-i) = [];
%     else
%         r2n(j) = numRows*numCols+1-i;
%         n2r(numRows*numCols+1-i) = j;
%         j = j-1;
%     end
% end        

% ws.adjn = adjn;
% ws.adjr = adjr;
% ws.r2n = r2n;
% ws.n2r = n2r;
ws.obstacles = obstacles;
ws.numRows = numRows;
ws.numCols = numCols;
ws.size = [numRows, numCols];