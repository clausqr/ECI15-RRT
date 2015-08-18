classdef Swarm < matlab.mixin.Copyable  
    % SWARM Set of functions to model a swarm of robots/UAVs
    %
    % (c) https://github.com/clausqr for ECI2015
    %
    %
    properties (GetAccess = public, SetAccess = protected)
  
    end
    
    methods (Access = public)
       
        %World creates a 1x1 world based on ObstacleMapImageFile and provides Cfree checking.
        function obj = World(ObstacleMapImageFile)

            % Initialize Obstaclemap
            obj.LoadObstacleMap(ObstacleMapImageFile);
        
        end
        
        % IsInCfree function, check if the line between points is in CFree
        function obj = IsInCfree(obj, a)
            
        end
    end
    
    methods (Static)
       
        obj = LoadObstacles(ObstacleMapImageFile)
        
    end
    
end
