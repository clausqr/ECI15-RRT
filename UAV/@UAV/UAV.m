classdef UAV < handle
    % UAV Set of functions to model a UAV of robots/UAVs and manipulate its state space.
    %
    % (c) https://github.com/clausqr for ECI2015
    %
    %
    properties (GetAccess = public, SetAccess = protected)
    
        % Properties for the actual instance that moves around (additional
        % static methods used for path planning modify these values only
        % through instance methods.
        
        InitialState
        State
        StateHistory
        CurrentIterationStep
   
    end
    
    methods (Access = public)
        
        % Constructor
        function obj = UAV(InitialState)
            
            obj.Init(InitialState);
            
        end
        
        function obj = Init(obj, InitialState)
            
            obj.InitialState = InitialState;
            obj.State = InitialState;
            obj.CurrentIterationStep = 1;
            
        end
        
        % Updates the state of the actual instance
        function obj = UpdateState(obj, u)
            
            k = obj.CurrentIterationStep;
            obj.StateHistory{k} = obj.State;
            
            obj.State = obj.StateTransitionFcn(obj.State, u);
            obj.CurrentIterationStep = k+1;
        end

    end
    
    % Following static methods are implemented here so they can be called
    % from the outside for path planning purposes, and from the inside for
    % actual instance movement.
    methods (Static)
        
        % State Transition function
        newstate = StateTransitionFcn(State, Controls)
        
        % Inverse Dynamics (or Kinematics) function, finds the right
        % control inputs to go towards a desired state, starting from the
        % current state.        
        controls = InverseKinematics(FromState, ToState)
        
        % Function to compute distance between a pair of states
        d = DistanceInStateSpace(x, y)
        
        % Function used to generate several variations of a control input,
        % used for branching
        us = ControlsShuffle(u)
        
        % Function used to get a random point in state space
        s = getNewRandomState()
        
        % Function used to plot a state
        h = PlotState(State, Style)
        
        % and to plot a transition between states
        PlotStateTransition(FromState, ToState, Controls, Style)
        
    end
    
end
