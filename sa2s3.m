%% GENERAL SCRIPT FOR HIGH LEVEL OF ABSTRACTION VREP SIMULATIONS
%
%
% //TODO get N_Quads amount of quads programmaticaly from VREP.
global N_Quads;
N_Quads = 3;
%
%
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%   (c) https://github.com/clausqr for ECI2015
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%% 

ConnectToVREP();


for k = 1:length(P)
    pos = getQuadPoses();
    new_pos = pos;
    new_pos(:,1) = vertices(:,P(k))*10;
    new_pos(3,1) = 0.5;
    setQuadTargetPoses(new_pos);
    pause(1)
end
    