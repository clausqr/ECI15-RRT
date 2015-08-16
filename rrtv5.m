clear
clf
tranqui = false;
x = 1; y = 2; z = 3;

% todo
% * k-d tree algorithm complexity reduction
% * keep a list of expandable nodes and don't touch the unexpandables
g = digraph;


%starting_point = getNewRandomPoint();
%goal = getNewRandomPoint();
starting_point = [0.1; 0.1; 0];
goal = [0.9; 0.9; 0];
goal_radius = 0.125;

vertices = starting_point;
edges = [];
g.addVertex(1);



% ObstacleMap = LoadObstacles('shape3.jpg');
ObstacleMap = LoadObstacles('shape2.jpg');
% ObstacleMap = LoadObstacles('maze3.png');
hold on
%axis equal

PlotStart(starting_point, goal_radius/8)
PlotGoal(goal, goal_radius)
PlotPoint(goal, 'or')

%axis([0 1 0 1]);

failed_attempts = 0;
failed_attempts_max = 5000;
distance_to_goal = 1;
        d = [];
delta_distance_to_goal = 0;

while (min((getDistancesPointToVertices(vertices, goal)) > goal_radius/2) &&...
        (failed_attempts < failed_attempts_max))
    
    
    new_random_point = getNewRandomPoint();
    h_new_random_point = PlotGoal(new_random_point, goal_radius/4);
    drawnow update

    if isInCFree(ObstacleMap, new_random_point)
     % vainilla
     vertex_length = goal_radius*(1/3);
      %  vertex_length = goal_radius*(1/3 + 10*(1-exp(10*delta_distance_to_goal/distance_to_goal)));
        
      %  vertex_length = goal_radius*(1/4)+distance_to_goal*chi2rnd(1);
        
      % vertex_length = goal_radius*(1/4)+distance_to_goal/4;
        
        [closest_vertex, closest_vertex_n] = getNearestVertex(vertices, new_random_point);
        
      %  vertices(3, closest_vertex_n) = vertices(3, closest_vertex_n) + 10*vertex_length;
        
        
        
        new_vertices = getNewAuxRRTVertices(closest_vertex,...
            new_random_point,...
            vertex_length,...
            [-30 0 30]);
%            90*rand(4,1)-45*ones(4,1));
        for i=1:size(new_vertices,2)
            % plot(new_random_point(1), new_random_point(2), '.k')
            new_vertex_to_add = new_vertices(:,i);
            
            if isInCFree(ObstacleMap, [closest_vertex new_vertex_to_add])
                old_distance_to_goal = distance_to_goal;
                distance_to_goal = min(getDistancesPointToVertices(vertices, goal));
                d = [d distance_to_goal];
                delta_distance_to_goal = old_distance_to_goal-distance_to_goal;
                if abs(delta_distance_to_goal) < 0.0001
                    failed_attempts = failed_attempts + 1;
                end
                
                [g, vertices, new_vertex_n] = addNewRRTVertex(g,...
                    vertices,...
                    new_vertex_to_add);
                
                new_edge_to_add = getNewRRTEdge(closest_vertex_n, new_vertex_n);
                
                % vertices(3, closest_vertex_n) = vertices(3, closest_vertex_n) + 10;
                
                [g, edges, new_edge_n] = addNewRRTEdge(g,...
                    edges,...
                    new_edge_to_add);
                
                PlotEdge(vertices, new_edge_to_add);
                PlotPoint(new_vertex_to_add, 'o');
                %stem3(vertices(1,:),vertices(2,:),vertices(3,:),'.')
           %     drawnow update
                
                
            else
                failed_attempts = failed_attempts + 1;
                warning(['New edge is not in CFree, it wont be added', num2str(failed_attempts)])
            end
            if (size(vertices,2)>2)
               if exist('h') 
                   delete(h);
               end
               h = voronoi(vertices(1,:),vertices(2,:));
            end

        end
        
    end
    delete(h_new_random_point);
    drawnow update

end

%%
[a, a_n] = getNearestVertex(vertices, goal);
p = g.shortestPath(1, a_n);

PlotPath(vertices, p)
