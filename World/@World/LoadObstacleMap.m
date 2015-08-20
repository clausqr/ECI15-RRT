function obj = LoadObstacleMap(obj, s)
    % LOADOBSTACLEMAP(FILE) Loads the Obstacle Map of the world object.
    %   H = W.LoadObstacleMap(OBJ) loads the Obstacle Map of the world
    %   object W from a file FILE.
    %
    % (c) https://github.com/clausqr for ECI2015    

% Load image
M = imread(s);
[ny, nx, nz] = size(M);

% Save it in the object
obj.ObstacleMap = im2double(M);
obj.nx = nx;
obj.ny = ny;
obj.nz = nz;

end
