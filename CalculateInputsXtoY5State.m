function u = CalculateInputsXtoY5State(x, y)

AngleYtoX = atan2(y(2)-x(2), y(1)-x(1));

current_state_angle = x(5);


delta_theta = AngleYtoX - current_state_angle;
%steering only control
delta_v = 0;

max_delta_theta = pi/8;
if delta_theta > max_delta_theta
    delta_theta = max_delta_theta;
elseif delta_theta < -max_delta_theta
    delta_theta = -max_delta_theta;
else
    delta_theta = 0;
end


u = [delta_v; delta_theta];

end