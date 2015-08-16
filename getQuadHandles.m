%getQuadHandles returns the list of handles to VREP Quadrotors.
%
%   Parameters:
%
%   Returns
% 
%       handles = getQuadHandles(cID)
%
% Needs the total amount of quads defined elsewhere by 
% 
%       global N_Quads 
%
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%   (c) https://github.com/clausqr for ECI2015
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


function handles = getQuadHandles(clientID)

    global N_Quads 
    persistent vrep
    
    if isempty(vrep)
        vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    end

    %N_Quads = 3;
handles = zeros(1, N_Quads);

for i = 1:N_Quads
    % Get handles
    if (i==1)
        quad_target = 'Quadricopter_target';
    else
        quad_target = ['Quadricopter_target#' num2str(i-2)];
    end
    disp(['Connecting to quad_target = ' quad_target '...']);
    [ret, handle] = vrep.simxGetObjectHandle(clientID, quad_target, vrep.simx_opmode_oneshot_wait);
    if (ret ~= vrep.simx_return_ok)
        warning(['Could not connect to Quadrotor ' i]); 
    else
        handles(i) = handle;
        disp(['OK, got handle ' num2str(handle)]);
    end
    
end

end
