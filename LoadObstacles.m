function ObstacleMap = LoadObstacles(s)

ObstacleMap = imread(s);

[nx, ny] = size(ObstacleMap);

imshow(ObstacleMap, 'XData', (1:nx)/nx, 'YData', (1:ny)/ny)

ObstacleMap = im2double(ObstacleMap);
end
