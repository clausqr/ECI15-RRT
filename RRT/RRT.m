classdef RRT < matlab.mixin.Copyable  %handle    %
    % RRT Rapid-growing Random Tree class, implementing the RRT pathfinder.
    %
    % (c) https://github.com/clausqr for ECI2015
    %
    % inspired by digraph class, it uses it in the insides...
    %
    properties (GetAccess = public, SetAccess = protected)
        % Vertices of the graph
        % READ-ONLY
        
        %  Vertix variables
        vertixState
        vertixId
        vertixChildren
        vertixFailedToExpandTimes
        VerticesListLength
        
        %  Edgevariables
        edgeControls
        edgeId
        edgeFromVertexId
        edgeToVertexId
        EdgesListLength
                
        % Debug
        Debug
        
                % world! (encapsulates Cfree checking methods)
        w 
        
        % agent encapsulates the properties of the robot or UAV being used.
        a 
    end
    
    properties (Access = protected)
        
        % Graph to hide the graph structure, properties and methods. For
        % the time being we use this from digraph class.
        % //TODO: reimplement a graph class.
        graph
        
        % Handles to functions
        %   to compute distance between vertices/states
        DistanceFcn
        %   to state transition function
        StateTransitionFcn
        %   select state to grow to
        SelectWhereToGrowToFcn
        %   calculate inputs to go from state x to y
        GrowthInputsFcn
        % Function to shuffle controls and produce the branching
        ControlShuffleFcn

        
    end
    
    %      properties (GetAccess = public, SetAccess = private)
    %
    %         %NUMVERTICES (read-only) Number of vertices in the graph
    %         %
    %         % See also VERTEX, NUMEDGES.
    %         NumVertices
    %
    %         %NUMEDGES (read-only) Number of explicit edges in the graph
    %         %
    %         % See also ADJMAT, NUMVERTICES.
    %         NumEdges
    %
    %      end
    
    methods (Access = public)
        
        function obj = RRT(AgentObject, WorldObject)
            %RRT creates an empty RRT object .
            %  Example:
            %   R = RRT(DistanceFcn)
            %
            %   parameters
            %
            %       DistanceFcn   is a function handle to a function that computes distances between states;
            
            % Initialize vertices
            obj.vertixState = [];
            obj.vertixId = [];
            obj.vertixChildren = [];
            obj.vertixFailedToExpandTimes = [];
            obj.VerticesListLength = 0;
            
            % Initialize edges
            obj.edgeControls = [];
            obj.edgeId = [];
            obj.edgeFromVertexId = [];
            obj.edgeToVertexId = [];
            obj.EdgesListLength = 0;
            
            % Initialize connectivity graph
            obj.graph = digraph();
            
            % Register state manipulation functions
            obj.a = AgentObject;
            
            % Register World Object
            obj.w = WorldObject;
            
            % Debug state
            obj.Debug = true;
            
        end
        
        % Grow function, here is where all the RRT magic happens
        function obj = Grow(obj)
            
            
            % NewStateToGrowTo = obj.SelectWhereToGrowToFcn(); 
            % //TODO: Use function handle to better encapsulate agents.
            NewStateToGrowTo = obj.a.getNewRandomState();
            VertexToGrowId = obj.SelectVertixToGrowFrom(NewStateToGrowTo);
            
            if obj.Debug
                h1 = obj.a.PlotState(NewStateToGrowTo, 'xr');
                p = obj.vertixState(:,VertexToGrowId);
                h2 = obj.a.PlotState(p, 'xg');
                h3 = line([p(1) NewStateToGrowTo(1)],...
                    [p(2) NewStateToGrowTo(2)],...
                    'LineStyle', ':');
                drawnow update
            end
            
            
            
            fromState = obj.vertixState(:,VertexToGrowId);
            toState = NewStateToGrowTo;
            
            % Generate controls if we want to expand right into the
            % randomly chosen state
            % //TODO: Use function handle to better encapsulate agents.
            %ControlInputs = obj.GrowthInputsFcn(fromState, toState);
            ControlInputs = obj.a.InverseKinematicsFcn(fromState, toState);
            
            % and shuffle these controls to produce branching.
            % //TODO: Use function handle to better encapsulate agents.
            %ShuffledControlInputs = obj.ControlShuffleFcn(ControlInputs);
            ShuffledControlInputs = obj.a.ControlsShuffle(ControlInputs);
            
            % Take into account the number of expanded branches.
            BranchesCount = size(ShuffledControlInputs, 2);
            ExpandedBranches = 0;
            
            for k = 1:BranchesCount
                
                u = ShuffledControlInputs(:,k);
                
               % //TODO: Use function handle to better encapsulate agents.

%                 NewStateToAdd = obj.StateTransitionFcn(...
                NewStateToAdd = obj.a.StateTransitionFcn(...
                    fromState,...
                    u);
                
                if obj.Debug
                    % pause(1)
                    h4 = obj.a.PlotState(NewStateToAdd, '*r');
                    p = obj.vertixState(:,VertexToGrowId);
                    h5 = obj.a.PlotState(p, '*g');
                    h6 = line([p(1) NewStateToAdd(1)],...
                        [p(2) NewStateToAdd(2)],...
                        'Color', 'Red');
                    drawnow update
                end
                
                if obj.w.PolygonIsInCFree([fromState NewStateToAdd])
                    
                    ExpandedBranches = ExpandedBranches + 1;
                    AddedVertexId = obj.AddVertexFromState(NewStateToAdd);
                    
                    obj.AddEdge(VertexToGrowId,...
                        AddedVertexId,...
                        u);
                    
                    obj.a.PlotStateTransition(obj.vertixState(:, VertexToGrowId),...
                        obj.vertixState(:, AddedVertexId));
                end
                
                if obj.Debug
                    % pause(1);
                    delete(h4)
                    delete(h5)
                    delete(h6)
                    drawnow update
                end
                
            end
            

            % Take note of the times we have expanded this vertex...
            obj.vertixChildren(VertexToGrowId) =... 
             obj.vertixChildren(VertexToGrowId) + ExpandedBranches;
            % and how many times we failed to expand it.
            obj.vertixFailedToExpandTimes(VertexToGrowId) =...
                obj.vertixFailedToExpandTimes(VertexToGrowId) +...
                BranchesCount - ExpandedBranches;
            
            if obj.Debug
                % pause(1);
                delete(h1)
                delete(h2)
                delete(h3)
                
                drawnow update
            end
            
        end
        
        function vid = SelectVertixToGrowFrom(obj, NewStateToGrowTo)
            
            vid = obj.getNearestVertexId(NewStateToGrowTo);

            vid = vid(1);

        end
        
        function obj = AddEdge(obj, vFromId, vToId, Controls)
            
            % get an id for the edge
            n = obj.EdgesListLength;
            id = n + 1;
            
            %//TODO: add more than one edge at a time (replace (1) with
            %(k))
            obj.edgeControls(:, n+1) = Controls(:,1);
            obj.edgeId(n+1) = id(1);
            obj.edgeFromVertexId(n+1) = vFromId(1);
            obj.edgeToVertexId(n+1) = vToId(1);
            
            % update the edge count
            obj.EdgesListLength = obj.EdgesListLength + 1;
            
            % add edge to the connectivity graph
            obj.graph.addEdge(vFromId(1), vToId(1));
            
        end
        
        function id = AddVertexFromState(obj, State)
            
            % Get a new id for the vertex
            n = obj.VerticesListLength;
            id =  n + 1;   %//TODO: find a smarter way to get a vertex id
            
            % fill in with vertex properties
            obj.vertixState(:, n+1) = State;
            obj.vertixId(n+1) = id;
            obj.vertixChildren(n+1) = 0;
            obj.vertixFailedToExpandTimes(n+1) = 0;
            
            % add vertex to vertex connectivity graph
            obj.graph.addVertex(id);
            
            % update the vertex count
            obj.VerticesListLength = n + 1;
            
        end
        
        function id = getNearestVertexId(obj, TargetState)
            
            distance_to_vertices = obj.getDistancesPointToVertices(obj.vertixState,...
                TargetState);
            id = obj.vertixId(distance_to_vertices == min(distance_to_vertices));
            
        end
        
        function d = getDistanceToState(obj, TargetState)
            
            distance_to_vertices = obj.getDistancesPointToVertices(obj.vertixState,...
                TargetState);
            d = min(distance_to_vertices);
        end
        
    end
    
    
    methods (Access = private)
        
        function d = getDistancesPointToVertices(obj, vertices, point)
            rays = bsxfun(@minus, vertices, point);
            % //TODO: Use function handle to better encapsulate agents.
            %dfcn = obj.DistanceFcn;
            %d = arrayfun(@(idx) dfcn(zeros(size(point)), rays(:,idx)), 1:size(rays,2));
            d = arrayfun(@(idx) obj.a.DistanceInStateSpace(zeros(size(point)), rays(:,idx)), 1:size(rays,2));
        end
    end
    
end
