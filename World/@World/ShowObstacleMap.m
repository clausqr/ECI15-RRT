function h = ShowObstacleMap(obj)
    % SHOWOBSTACLEMAP Shows the Obstacle Map of the world object.
    %   H = W.ShowObstacleMap(OBJ) shows the Obstacle Map of the world
    %   object W, and returns a graphics handle H.
    %
    % (c) https://github.com/clausqr for ECI2015    
obj = obj.ObstacleMap;
nx = obj.nx;
ny = obj.ny;
nz = obj.nz;

h = imshow(M, 'XData', (1:nx)/nx, 'YData', (1:ny)/ny);
