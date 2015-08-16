%getNearestVertices finds the nearest vertices to a goal point
%
%   [closest_vertices_to_goal, closest_vertices_to_goal_n] = getNearestvertices(vertices, goal)
%
% https://github.com/clausqr

function [closest_vertices_to_goal, closest_vertices_to_goal_n] = getNearestVertices(vertices, goal, n)

closest_vertices_to_goal = [];
closest_vertices_to_goal_n = []; 

i=0;
while i<n
    i = i+1;
  
    [v, v_n] = getNearestVertex(vertices, goal);
    vertices(:, v_n) = NaN;
    closest_vertices_to_goal   = [closest_vertices_to_goal v];
    closest_vertices_to_goal_n = [closest_vertices_to_goal_n v_n];
   
end


end
