function obj = LoadObstacleMap(obj, s)

M = imread(s);

[ny, nx, nz] = size(M);

imshow(M, 'XData', (1:nx)/nx, 'YData', (1:ny)/ny)

obj.ObstacleMap = im2double(M);
obj.nx = nx;
obj.ny = ny;
obj.nz = nz;

end
