%getNearestVertex finds the nearest vertex to a goal point
%
%   [closest_vertex_to_goal, closest_vertex_to_goal_n] = getNearestVertex(vertices, goal)
%
%   https://github.com/clausqr

function [closest_vertex_to_goal, closest_vertex_to_goal_n] = getNearestVertex(vertices, goal)

   
    distance_to_vertices = getDistancesPointToVertices(vertices, goal);

    closest_vertex_to_goal_n = find(distance_to_vertices == min(distance_to_vertices));
    closest_vertex_to_goal = vertices(:,closest_vertex_to_goal_n);

end
