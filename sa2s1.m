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


for k = 1:10
    pos = getQuadPoses();
    new_pos = 1.2*pos;
    setQuadTargetPoses(new_pos);
    pause(5)
    new_pos = 0.8*pos;
    setQuadTargetPoses(new_pos);
    
end
    