% rrtv6
% script to test and run the RRT path finder
clear
hold off
% amount of robots
N_robots = 2;

% Starting position, attitude and initial velocity
Path.Start.pos(:,1) = [0.1; 0.1; 0.5];
Path.Start.vel(:,1) = 0.02;
Path.Start.ang(:,1) = pi/3;

% Starting position, attitude and initial velocity
Path.Start.pos(:,2) = [0.2; 0.1; 0.5];
Path.Start.vel(:,2) = 0.02;
Path.Start.ang(:,2) = pi/6;


% Goal and goal size.
Path.Goal.pos(:,1) = [0.9; 0.9; 0.5];
Path.Goal.Radius(1) = 0.125;
Path.Goal.pos(:,2) = [0.8; 0.9; 0.5];
Path.Goal.Radius(2) = 0.125;

% our world is a square [0; 1]x[0; 1], the following image represents
% this square, ObstacleMap is a matrix of the same size as the image.
World.ObstacleMap = LoadObstacles('shape2.jpg');

% plot starting positions and goal
for k = 1:N_robots
    hold on
    PlotCircle(Path.Start.pos(:,k), Path.Goal.Radius(k)/8, 3, 'Green');
    PlotPoint(Path.Start.pos(:,k), '*g');
    PlotCircle(Path.Goal.pos(:,k), Path.Goal.Radius(k), 3, 'Red');
    PlotPoint(Path.Goal.pos(:,k), '*r');
end



for k = 1:N_robots
    
    % Construct the state vector of the k-th robot
    InitialState{k} = [Path.Start.pos(:,k);
        Path.Start.vel(:,k);
        Path.Start.ang(:,k)];
    
    % Initialize the robot
    r(k) = Robot(InitialState{k});
    
    g(k) = RRT();
    % Add the starting vertex to the RRT graph
    g(k).AddVertexFromState(InitialState{k});
    
end

hold on


sigma_delta_v = 0.0;
sigma_delta_theta = 2*pi/2;

for i = 1:200
    for k = 1:N_robots
        
        
        g(k).Grow(@getNewRandomState,...
                    @StateUpdateFcn2DAngle,...
                    @CalculateInputsXtoY5State,...
                    @DistanceXYFrom5State);

      PlotPoint(g(k).Vertices(i).State(1:2),'ob');
        drawnow update
    end
    
end







