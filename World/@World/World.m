classdef World < matlab.mixin.Copyable
    % WORLD is a class to model Obstacle Maps and C_free checking, meant to be used with RRT.
    % (c) https://github.com/clausqr for ECI2015
    %
    % See also RRT.
    
    properties (GetAccess = public, SetAccess = protected)
        
        ObstacleMap     % map of world
        
        nx              % size of the world along x-axis
        ny              % size of the world along y-axis
        nz              % size of the world along x-axis
        
    end
    
    methods (Access = public)
        
        function obj = World(varargin)
        % World constructor creates a 1x1 world based on ObstacleMapImageFile and provides Cfree checking.
            
            if nargin == 1
                
                ObstacleMapImageFile = varargin{1};
                % Initialize Obstaclemap
                obj.LoadObstacleMap(ObstacleMapImageFile);
            end
        end
        
        isIt = PolygonIsInCFree(obj, a) % Checks if polygon defined in a is in CFree of current world Obstacle Map.
        
    end
    
    methods (Access = private)
        
        obj = LoadObstacles(ObstacleMapImageFile) % Loads the Obstacle Map of the world object.
        
    end
    
        methods (Static)
        
        h = ShowObstacleMap(obj);   % Shows the obstacle map
        
    end
    
end
