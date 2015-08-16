
function h = PlotGoal(goal, goal_radius)

% z = goal_radius*exp((0:2*pi/36:2*pi)*1i);
% plot(goal(1)+real(z), goal(2)+imag(z), 'r', 'LineWidth', 1);

z = 1/2*goal_radius*exp((0:2*pi/36:2*pi)*1i);
h = plot(goal(1)+real(z), goal(2)+imag(z), 'r', 'LineWidth', 3);
