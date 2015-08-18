classdef Agent < handle
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (GetAccess = public, SetAccess = protected)
        
        % Actual robot used for this agent.
        r
        
                DistanceInStateSpace
                StateTransitionFcn
                getNewRandomState
                InverseKinematics
                ControlShuffleFcn
                
    end
    
    methods (Access = public)
        
        function obj = Agent(varargin)
            
            if nargin == 1
                disp('Beign called with argument')
                Robot = varargin;
                obj.r = Robot;
                
                obj.DistanceInStateSpace = @Robot.DistanceInStateSpace;
                obj.StateTransitionFcn = @Robot.StateTransitionFcn;
                obj.getNewRandomState = @Robot.getNewRandomState;
                obj.InverseKinematics = @Robot.InverseKinematics;
                obj.ControlShuffleFcn = @Robot.ControlShuffleFcn;
                
            else
                disp('Beign called without argument')
            end
            
        end
        
        
        
    end
    
end

