function plot_kantaros(ws,pos)
figure(1)
clf;
hold on
min_xy = min(ws.points)-1;
max_xy = max(ws.points)+1;
axis([min_xy(1) max_xy(1) min_xy(2) max_xy(2)])
nTeams = length(ws.C);
mycolors = jet(nTeams+size(pos,2));
for n = 1:nTeams
    plot(ws.points(ws.C{n},1), ws.points(ws.C{n},2),...
        '-s','MarkerEdgeColor','k', 'MarkerFaceColor',mycolors(n,:))
end

for n = 1:size(pos,2)
    plot(pos(1,n), pos(2,n),...
    'o', 'MarkerFaceColor',mycolors(nTeams+n,:), 'MarkerEdgeColor','k');
end
    
