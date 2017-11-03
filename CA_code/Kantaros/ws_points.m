function ws = ws_points()
ws = struct();
points = [15 2; 15 5; 15 8;...
          14 9;
          13 4; 13 10;
          12 12; 12 15;
          10 12; 10 15;
          5 3; 5 5; 5 11; 5 15;
          3 4;
          2 3; 2 5; 2 12; 2 13; 2 14];
      
C = cell(5,1);
C{1} = [1 2 5];
C{2} = [3 4 6];
C{3} = [7 8 9 10];
C{4} = [13 14 18 19 20];
C{5} = [11 12 15 16 17];

A = zeros(size(points,1));
for n = 1:size(points,1)-1
    for m = n+1:size(points,1)
        p1 = points(n,:);
        p2 = points(m,:);
        A(n,m) = norm(p1-p2,2);
        A(m,n) = norm(p1-p2,2);
    end
end
ws.points = points;
ws.C = C;
ws.A = A;