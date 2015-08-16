%ConnectToVREP connects to VREP and returns the Client ID.
%
%   Parameters:
%
%       //TODO  add parameters (network, etc.)
%
%   Returns
%
%       nothing
%
%
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%   (c) claus for ECI2015
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

function ConnectToVREP()

    global clientID
    persistent vrep
    
    if isempty(vrep)
        vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    end

disp('Call to ConnectToVREP()...');
% vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
vrep.simxFinish(-1); % just in case, close all opened connections
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
    disp('Connected to remote API server');
else
    error('Could not connect to remote API server');
end



end
