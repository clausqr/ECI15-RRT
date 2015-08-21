classdef SWARM < handle
    % SWARM Set of functions to model a UAV SWARM and manipulate its state space.
    % (c) https://github.com/clausqr for ECI2015
    %
    %  Provides methods to model an instance of a SWARM but also exposes its
    %  static methods to update state, generate and manipulate controls,
    %  etc, and also to plot the states.
    properties (GetAccess = public, SetAccess = protected)
        
        % Properties for the actual instance that moves around (additional
        % static methods used for path planning modify these values only
        % through instance methods.
        
        % Replicates the Agent interface for properties and methods, and
        % encapsulates the 1 to many translations
        
        InitialState    % Initial Sate
        State           % Current State
        StateHistory    % State History
        CurrentIterationStep    % Current Iteration Step
        
        UAV     % list of UAVs.
        UAVCount % Count of UAVs
        
        n_states    % number of states for each UAV
        n_inputs    % number of inputs for each UAV
    end
    
    methods (Access = public)
        
        % Constructor
        function obj = SWARM()
            
            obj.UAVCount = 0;
        end
        
        function obj = AddUAV(obj, a)
            
            n = obj.UAVCount;
            if (n == 0)
                obj.UAV = a;
            else
                obj.UAV(n+1) = a;
            end
            
            % Hack to obtain the number of states,
            % //TODO: find a better way to obtain it!
            obj.n_states = numel(obj.UAV(1).getNewRandomState);
            
            k = n+1;
            idxs = (obj.n_states*(k-1)+1):(obj.n_states*k);
            obj.State(idxs,1) = obj.UAV(k).State;
            
            
            obj.UAVCount = n+1;
            
        end
        
        function obj = Init(obj, InitialStates)
            n = obj.UAVCount;
            % Hack to obtain the number of states,
            % //TODO: find a better way to obtain it!
            
            if isempty(obj.n_states)
                obj.n_states = numel(obj.UAV(1).getNewRandomState);
            end
            
            for k = 1:n
                idxs = (obj.n_states*(k-1)+1):(obj.n_states*k);
                obj.UAV(k).Init(InitialStates(idxs));
                obj.State(idxs) = obj.UAV(k).State;
            end
        end
        
        % Updates the state of the actual instance
        function obj = UpdateState(obj, u)
            
            
            n = obj.UAVCount;
            
            % Hack to obtain the number of states and inputs,
            % //TODO: find a better way to obtain it!
            if isempty(obj.n_inputs)
                x = obj.UAV(1).getNewRandomState;
                temp_u = obj.UAV(1).InverseKinematicsFcn(x, x);
                obj.n_inputs = numel(temp_u);
            end
            
            for k = 1:n
                idxs_inputs = (obj.n_inputs*(k-1)+1):(obj.n_inputs*k);
                idxs_states = (obj.n_states*(k-1)+1):(obj.n_states*k);
                obj.UAV(k).UpdateState(u(idxs_inputs));
                obj.State(idxs_states) = obj.UAV(k).State;
            end
        end
        
        % Following function can't be static, depends on number of states
        % and inputs.
        newstate = StateTransitionFcn(obj, State, Controls)  % State Transition function

        
    end
    
    % Following static methods are implemented here so they can be called
    % from the outside for path planning purposes, and from the inside for
    % actual instance movement.
    
    methods (Static)
        
        controls = InverseKinematics(FromState, ToState)  % Inverse Dynamics (or Kinematics) function
        
        d = DistanceInStateSpace(x, y) % Function to compute distance between a pair of states
        
        us = ControlsShuffle(obj, u) % Function used to generate several variations of a control input, used for branching
        
        s = getNewRandomState() % Function used to get a random point in state space
        
        h = PlotState(State, Style) % Function used to plot a state
        
        PlotStateTransition(varargin) % and to plot a transition between states
        %PlotStateTransition(FromState, ToState, Controls, Style, Width) % and to plot a transition between states
        
    end
    
end
