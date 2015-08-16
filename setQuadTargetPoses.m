%setQuadTargetPoses sets target positions of VREP Quadricopters.
%
%   Parameters:
%%
%       pos_list   poses of quads, n x 3 matrix:
%
%
% Needs the total amount of quads defined elsewhere by 
% 
%       global N_Quads 
%
function setQuadTargetPoses(pos_list)

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



for i = 1:N_Quads
    handle = quad_handles(i);
    new_pos = pos_list(:,i);
    ret = vrep.simxSetObjectPosition(clientID, handle, -1, new_pos, vrep.simx_opmode_oneshot_wait);
    if (ret ~= vrep.simx_return_ok)
        error(['Failed to set position for Quadricopter_target, handle =' handle])
    end
    
    
    
end

