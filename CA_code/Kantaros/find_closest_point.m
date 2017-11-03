function p = find_closest_point(team, pos, ws)
    total_dist = zeros(length(team.ComPts),1);
    for c = 1:length(team.ComPts)
       cp = team.ComPts(c);
       cp = ws.points(cp, :);
       for r = 1:length(team.robots)
          robotID = team.robots(r);
          pos_r = pos(:,robotID);
          total_dist(c) = total_dist(c) + norm(cp-pos_r,2);
       end
    end
    [min_dist, cp] = min(total_dist);
    p = ws.points(team.ComPts(cp),:)';
end