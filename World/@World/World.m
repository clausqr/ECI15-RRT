classdef World < matlab.mixin.Copyable  
    % RRT Rapid-growing Random Tree class, implementing the RRT pathfinder.
    %
    % (c) https://github.com/clausqr for ECI2015
    %
    % inspired by digraph class, it uses it in the insides...
    %
    properties (GetAccess = public, SetAccess = protected)
        % Vertices of the graph
        % READ-ONLY
        
        %  map of world
        ObstacleMap
        
        % sizes
        nx
        ny
        nz
   
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
    
    methods (Access = private)
       
        obj = LoadObstacles(ObstacleMapImageFile)
        
    end
    
end
