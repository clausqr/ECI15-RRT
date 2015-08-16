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
        Vertices
        VerticesListLength
        
        % Edges of the graph
        % READ-ONLY
        Edges
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
                            SelectWhereToGrowToFcn)
            %RRT creates an empty RRT object .
            %  Example:
            %   R = RRT(DistanceFcn)
            %
            %   parameters
            %
            %       DistanceFcn   is a function handle to a function that computes distances between states;
            obj.graph = digraph();
            
            % Initialize vertices
            obj.Vertices.State = [];
            obj.Vertices.id = [];
            obj.Vertices.IsExpandable = [];
            obj.VerticesListLength = 0;
  
            % Initialize edges
            obj.Edges = [];
            obj.EdgesListLength = 0;
            obj.graph = digraph();
            
            % Register Distance function
            obj.DistanceFcn = DistanceFcn;
            obj.StateTransitionFcn = StateTransitionFcn;
            obj.SelectWhereToGrowToFcn = SelectWhereToGrowToFcn;
            
        end
        
        function obj = Grow(obj, GrowthInputsFcn)
            
            NewStateToGrowTo = obj.SelectWhereToGrowToFcn();
            VerticesToGrowId = obj.SelectVerticesToGrowFrom(NewStateToGrowTo);
            
            from = obj.Vertices(VerticesToGrowId).State;
            to = NewStateToGrowTo;
            u = GrowthInputsFcn(from, to);
            
                NewStateToAdd = obj.StateTransitionFcn(...
                    from,...
                    u);
                
                VerticesToAddId = obj.AddVertexFromState(NewStateToAdd);
                obj.AddEdges(VerticesToGrowId,...
                    VerticesToAddId,...
                    u);
                
        end
        
        function vids = SelectVerticesToGrowFrom(obj, NewStateToGrowTo)
            vids = obj.getNearestVertexId(NewStateToGrowTo);
        end
        
        function obj = AddVertices(obj, VerticesToAdd)
            
            for k = 1:length(VerticesToAdd)
                
                v = VerticesToAdd(k);
                
                id = v.id;
                obj.graph.addVertex(id);
                
                n = obj.VerticesListLength;
                obj.Vertices(n+1) = v;
                obj.VerticesListLength = n+1;
                
            end
        end
        
        function obj = AddEdges(obj, VerticesFrom, VerticesTo, Controls)
            
            n1 = length(VerticesFrom);
            n2 = length(VerticesTo);
            for k1 = 1:n1
                for k2 = 1:n2
                    
                    vFrom = VerticesFrom(k1);
                    vTo = VerticesTo(k2);
                    
                    obj.graph.addEdge(vFrom, vTo);
                    
                    n = obj.EdgesListLength;
                    if isempty(obj.Edges)
                        obj.Edges.Controls = Controls;
                                        obj.Edges.From = vFrom;
                    obj.Edges.To = vTo;

                    else
                        obj.Edges(:,n+1).Controls = Controls;
                    obj.Edges(n+1).From = vFrom;
                    obj.Edges(n+1).To = vTo;

                    end
                     
                    obj.EdgesListLength = n+1;
                    
                end
            end
            
        end
        
        function id = AddVertexFromState(obj, State)
            v.State = State;
            id = obj.VerticesListLength + 1;      %//TODO change to id = hash
            v.id = id;
            v.IsExpandable = true;
            obj.AddVertices(v);
        end
        
        function id = getNearestVertexId(obj, TargetState)
            
            
            % //TODO: Vectorize this
            vs = zeros(size(obj.Vertices(1).State,1), obj.VerticesListLength);
            ids = zeros(1,obj.VerticesListLength);
            
            for k = 1:obj.VerticesListLength
                vs(:,k) = obj.Vertices(k).State;
                ids(k) = obj.Vertices(k).id;
            end
            
            distance_to_vertices = obj.getDistancesPointToVertices(vs,...
                TargetState);
            id = ids(distance_to_vertices == min(distance_to_vertices));
            
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
