classdef Robot < handle
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (GetAccess = public, SetAccess = protected)
        
        
        InitialState
        
        State
        StateHistory
        
        CurrentIterationStep
        
        
    end
    
    methods (Access = public)
        
        function obj = Robot(InitialState)
            
            obj.Init(InitialState);
            
        end
        
        function obj = Init(obj, InitialState)
            
            obj.InitialState = InitialState;
            obj.State = InitialState;
            obj.CurrentIterationStep = 1;
            
        end
        
        function obj = UpdateState(obj, StateUpdateFcn, u)
            
            k = obj.CurrentIterationStep;
            obj.StateHistory{k} = obj.State;
            
            obj.State = StateUpdateFcn(obj.State, u);
            obj.CurrentIterationStep = k+1;
        end
        
    end
    
end

