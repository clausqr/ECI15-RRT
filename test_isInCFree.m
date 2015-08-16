
 ObstacleMap = LoadObstacles('maze3.png');
 
 p1 = [0.1; 0.1; 0];
 
 p2 = [0.9; 0.9; 0];
 hold on
 
 PlotPoint(p1, 'or')
 PlotPoint(p2, 'xr')
 
 PlotEdge([p1 p2], [1 2]) 
 
 isInCFree(ObstacleMap, [p1 p2])