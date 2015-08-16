function u = CalculateInputsXtoY5State(x, y)

AngleXtoY = atan2(y(2)-x(2), y(1)-x(1));

current_state_angle = x(5);


delta_theta = AngleXtoY - current_state_angle;
%steering only control
delta_v = 0;

u = [delta_v; delta_theta];
end