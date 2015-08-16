%getQuadPoses returns the list of positions of VREP Quadricopters.
%
%   Parameters:
%
% 
%   Returns
% 
%       pos_list = getQuadPoses(c)   poses of quads, 3 x n matrix:
%
%       pos_list = [x1 x2 ... xn;
%                   y1 y2 ... yn;
%                   z1 z2 ... zn];    
%
% Needs the total amount of quads defined elsewhere by 
% 
%       global N_Quads 
%
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%   (c) https://github.com/clausqr for ECI2015
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

function pos_list = getQuadPoses()

    global clientID    
    global N_Quads 
    persistent vrep    
    persistent quad_handles
    
    if isempty(vrep)
        vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    end
    
    
    if isempty(quad_handles)
        quad_handles = getQuadHandles(clientID);
    end
    
    %N_Quads = 3;
    pos_list = zeros(3, N_Quads);
    for i = 1:N_Quads
        handle = quad_handles(i);
       [ret, pos] = vrep.simxGetObjectPosition(clientID, handle, -1, vrep.simx_opmode_oneshot_wait);
       
       if (ret ~= vrep.simx_return_ok)
            error(['Failed to get position for Quadricopter_target, handle =' num2str(handle)])
       else
            pos_list(:,i) = pos;
       end
    end
           
end