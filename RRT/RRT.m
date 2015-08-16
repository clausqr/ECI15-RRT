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
        vertixIsExpandable
        VerticesListLength
        
        %  Edgevariables
        edgeControls
        edgeId
        edgeFromVertexId
        edgeToVertexId
        EdgesListLength
        
    end
    
    properties (Access = private)
        
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
        
        function obj = RRT(DistanceFcn,...
                StateTransitionFcn,...
                SelectWhereToGrowToFcn,...
                GrowthInputsFcn)
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
            obj.vertixIsExpandable = [];
            obj.VerticesListLength = 0;
            
            % Initialize edges
            obj.edgeControls = [];
            obj.edgeId = [];
            obj.edgeFromVertexId = [];
            obj.edgeToVertexId = [];
            obj.EdgesListLength = 0;
            
            % Initialize connectivity graph
            obj.graph = digraph();
            
            
            
            % Register Distance function
            obj.DistanceFcn = DistanceFcn;
            obj.StateTransitionFcn = StateTransitionFcn;
            obj.SelectWhereToGrowToFcn = SelectWhereToGrowToFcn;
            obj.GrowthInputsFcn = GrowthInputsFcn;
            
        end
        
        function obj = Grow(obj)
            
            NewStateToGrowTo = obj.SelectWhereToGrowToFcn();
            VerticesToGrowId = obj.SelectVerticesToGrowFrom(NewStateToGrowTo);
            
            from = obj.vertixState(:,VerticesToGrowId);
            to = NewStateToGrowTo;
            u = obj.GrowthInputsFcn(from, to);
            
            NewStateToAdd = obj.StateTransitionFcn(...
                from,...
                u);
            
            VerticesToAddId = obj.AddVertexFromState(NewStateToAdd);
            obj.AddEdge(VerticesToGrowId,...
                VerticesToAddId,...
                u);
            
        end
        
        function vids = SelectVerticesToGrowFrom(obj, NewStateToGrowTo)
            vids = obj.getNearestVertexId(NewStateToGrowTo);
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
            obj.vertixIsExpandable = true;
            
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
        
    end
    
    
    methods (Access = private)
        
        function d = getDistancesPointToVertices(obj, vertices, point)
            rays = bsxfun(@minus, vertices, point);
            dfcn = obj.DistanceFcn;
            d = arrayfun(@(idx) dfcn(zeros(size(point)), rays(:,idx)), 1:size(rays,2));
        end
    end
    
    methods (Static)
        
        function v = CreateVertexFromState(obj, State)
            v.State = State;
            v.id = obj.VerticesListLength+1;      %//TODO change to id = hash
            
        end
    end
end
