classdef UAV < matlab.mixin.Copyable
    % UAV Set of functions to model a UAV of robots/UAVs and manipulate its state space.
    %
    % (c) https://github.com/clausqr for ECI2015
    %
    %
    properties (GetAccess = public, SetAccess = protected)
        
    end
    
    methods (Access = public)
        
        % Constructor
        function obj = UAV()
            

            
        end

    end
    
    % Following static methods are implemented here so they can be called
    % from the outside
    methods (Access = public, Static)
        
        % State Transition function
        newstate = StateTransitionFcn(state, input)
        
        % Inverse Dynamics (or Kinematics) function, finds the right
        % control inputs to go towards a desired state, starting from the
        % current state.        
        controls = InverseKinematics(FromState, ToState)
        
        
        
    end
    
end
