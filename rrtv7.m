% rrtv7
% script to test and run the RRT path finder
clear
hold off
addpath('digraph')
addpath('World')
addpath('UAV')
addpath('RRT')

% amount of Agents
N_Agents = 1;

% Starting position, attitude and initial velocity
Path.Start.pos(:,1) = [0.1; 0.1; 0.5];
Path.Start.vel(:,1) = 0.025;
Path.Start.ang(:,1) = -pi/2;

% Starting position, attitude and initial velocity
Path.Start.pos(:,2) = [0.2; 0.1; 0.5];
Path.Start.vel(:,2) = 0.025;
Path.Start.ang(:,2) = -pi/2;

% Goal and goal size.
Path.Goal.pos(:,1) = [0.9; 0.9; 0.5];
Path.Goal.state = [Path.Goal.pos(:,1); 0; 0];
Path.Goal.Radius(1) = 0.125;
Path.Goal.pos(:,2) = [0.8; 0.9; 0.5];
Path.Goal.state = [Path.Goal.pos(:,1); 0; 0];
Path.Goal.Radius(2) = 0.125;

% our world is a square [0; 1]x[0; 1], the following image represents
% this square, ObstacleMap is a matrix of the same size as the image.
w = World('shape3.jpg');
w.ShowObstacleMap(w);

% plot starting positions and goal
for k = 1:N_Agents
    hold on
    PlotCircle(Path.Start.pos(:,k), Path.Goal.Radius(k)/8, 3, 'Green');
    PlotPoint(Path.Start.pos(:,k), '*g');
    PlotCircle(Path.Goal.pos(:,k), Path.Goal.Radius(k), 3, 'Red');
    PlotPoint(Path.Goal.pos(:,k), '*r');
end



for k = 1:N_Agents
    
    % Construct the state vector of the k-th Agent
    InitialState{k} = [Path.Start.pos(:,k);
        Path.Start.vel(:,k);
        Path.Start.ang(:,k)];
    
    % Initialize the Agent
    r(k) = UAV(InitialState{k});
    
    g(k) = RRT(r(k),...
                w);
            
    % Add the starting vertex to the RRT graph
    g(k).AddVertexFromState(InitialState{k});
    
end

hold on

% Max number of iterations
N_iterations = 400;
% initialize distance logging into d, d(i, k) is the k-th agent distance to
% the goal on the i-th iteration
d = zeros(N_Agents, N_iterations);

for i = 1:N_iterations
    for k = 1:N_Agents
        
        g(k).Grow();
        d(k, i) = g(k).getDistanceToState(Path.Goal.state);

        drawnow update
    end
    
end

figure
plot(d(1,:))
hold on
plot(d(2,:))



