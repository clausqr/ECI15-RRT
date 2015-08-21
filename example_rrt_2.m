% rrtv7
% script to test and run the RRT path finder for random starting and goal
% point
clear
hold off
addpath('digraph')
addpath('World')
addpath('UAV')
addpath('RRT')

% amount of Agents
N_Agents = 1;

% Starting position, attitude and initial velocity
Path.Start.state(:,1) = UAV.getNewRandomState();
Path.Start.state(4,1) = 1/25;   % Initial velocity, since we are doing 
                                % steering only control in this example,
                                % this becomes the step size.

% Goal and goal size.
Path.Goal.state(:,1) = UAV.getNewRandomState();
Path.Goal.Radius(1) = 0.125;

% our world is a square [0; 1]x[0; 1], the following image represents
% this square, ObstacleMap is a matrix of the same size as the image.
w = World('shape4.png');
w.ShowObstacleMap(w);

% plot starting positions and goal
for k = 1:N_Agents
    hold on
    PlotCircle(Path.Start.state(1:2,k), Path.Goal.Radius(k)/8, 3, 'Green');
    PlotPoint(Path.Start.state(1:2,k), '*g');
    PlotCircle(Path.Goal.state(1:2,k), Path.Goal.Radius(k), 3, 'Red');
    PlotPoint(Path.Goal.state(1:2,k), '*r');
end


% Initialize states, RRT and world.
for k = 1:N_Agents
    
    % Initialize the Agent with the initial state vector of the k-th Agent
    r(k) = UAV();
    r(k).Init(Path.Start.state(:,k));
    
    g(k) = RRT(r(k),...
        w);
    
    % Add the starting vertex to the RRT graph
    g(k).AddVertexFromState(Path.Start.state(:,k));
    
end

hold on

% Max number of iterations
N_max_iterations = 400;
% initialize distance logging into d, d(k, i) is the k-th agent distance to
% the goal on the i-th iteration
d = zeros(N_Agents, N_max_iterations);
% Initialize variables for the while loop
i = 1;
for k = 1:N_Agents
    d(k, i) = g(k).getDistanceToState(Path.Goal.state(:,k));
end
Path.Goal.Reached = false;

while (i < N_max_iterations) && ~Path.Goal.Reached
    
    for k = 1:N_Agents
        
        g(k).Grow();
        d(k, i) = g(k).getDistanceToState(Path.Goal.state(:,k));
        
        
    end
    drawnow update
    Path.Goal.Reached = logical(sum(d(k, i) < Path.Goal.Radius(1:N_Agents)) >= N_Agents);
    i = i+1;
end

% trim distance log
d = d(:, 1:i-1);

%%
% actually find the path!
for k = 1:N_Agents
    [Path.States, Path.Controls] = g(k).FindPathBetweenStates(Path.Start.state(:,k),...
                                Path.Goal.state(:,k));
    % Plot it!
    PlotPath(Path.States, Path.Controls);
    
end

%% 
% plot convergence plot
figure('Name', 'Convergence Plot')
title('Convergence Plot')
hold on
    xlabel('Iterations [n]');
    ylabel('Distance [normalized]');

for k = 1:N_Agents
    plot(d(k,:))
end







