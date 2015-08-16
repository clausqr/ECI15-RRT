classdef digraph < matlab.mixin.Copyable
%DIGRAPH Directed-Graph object
    %  Allows for digraph computations while retaining names of vertices.
    %
    %  Example:
    %   dg = DIGRAPH;
    %   addVertex(dg,'A')
    %   addVertex(dg,'B')
    %   addVertex(dg,'C')
    %   addEdge(dg,'A','B')
    %   addEdge(dg,'B','C')
    %   shortestPath(dg,'A','C')
    %
    %  DIGRAPH Properties:
    %   AdjMat            - Adjacency Matrix
    %   Vertex            - Cell array of vertex names/labels
    %   NumVertices       - Number of vertices in DIGRAPH
    %   NumEdges          - Number of edges in DIGRAPH
    %
    %  DIGRAPH Methods:
    %   digraph           - creates an empty DIGRAPH object
    %   isEquivalent      - returns true if the specified DIGRAPH is
    %                       equivalent
    %   isempty           - returns true if DIGRAPH has no vertices
    %
    %  Vertex Methods:
    %   addVertex         - adds one vertex to DIGRAPH
    %   hasVertex         - returns true if DIGRAPH contains the specified
    %                       vertex
    %   assertVertex      - returns index of specified vertex, errors if
    %                       not found
    %   removeVertex      - removes specified vertex from DIGRAPH
    %
    %  Edge Methods:
    %   addEdge           - adds one edge to DIGRAPH between vertices
    %   hasEdge           - returns true if there is an edge between
    %                       specified vertices
    %   removeEdge        - removes edge from specified vertices
    %
    %  Search Methods:
    %   findall           - returns all vertices "ahead" or "behind" a
    %                       specific vertex up to a specified depth
    %   hasCycle          - returns true if any vertex has a path to itself
    %   hasPath           - returns true if there are edges connecting a
    %                       pair of specified vertices
    %   isComplete        - returns true if each vertex has a path to all
    %                       vertices
    %   shortestPath      - returns the shortest sequential list of
    %                       vertices connecting the specified pair of
    %                       vertices
    %
    %  Manipulation Methods:
    %   copy              - returns a "deep" copy of DIGRAPH
    %   intersect         - find vertices and edges found in both digraphs
    %   minimalEdges      - returns a DIGRAPH with a minimal number of
    %                       edges while preserving the structure
    %   reset             - resets DIGRAPH to the default state
    %   sort              - returns a digraph with sorted vertices
    %   subgraph          - returns a subgraph containing the specified
    %                       vertices and their edges
    %   transitiveClosure - returns a digraph with all explicit edges
    %   union             - find vertices and edges found in either digraph
    %
    %  Display Methods:
    %   spy               - Visualize sparsity pattern of AdjMat
    %
    % See also SPARSE, CONTAINERS.MAP.
    
    % Copyright 2013-2014 The MathWorks, Inc.
    
    
    % PROPERTIES
    properties (GetAccess = public, SetAccess = protected)
        
        %ADJMAT (set-protected) Sparse boolean Adjacency Matrix
        % AdjMat(i,j) is true iff Vertex{i} points to Vertex{j}
        %
        % See also ADDEDGE, HASEDGE.
        AdjMat
        
    end
    
    properties (GetAccess = public, SetAccess = private)
        
        %VERTEX (read-only) Cell array of vertex names/labels
        % Access vertex k on digraph dg by calling dg.Vertex{k}.
        %
        % See also ADDVERTEX, HASVERTEX.
        Vertex
        % This indexes AdjMat indices back to Vertex names. Can't be
        % dependent since the KEYS method of containers.Map will always
        % sort the resulting cell array, ruining the index-to-name hash.
        
    end
    
    properties (Dependent = true, GetAccess = public, SetAccess = private)
        
        %NUMVERTICES (read-only) Number of vertices in the graph
        %
        % See also VERTEX, NUMEDGES.
        NumVertices
        
        %NUMEDGES (read-only) Number of explicit edges in the graph
        %
        % See also ADJMAT, NUMVERTICES.
        NumEdges
        
    end
    
    properties (Access = private)
        
        %HASHMAP containers.Map object that indexes Vertex Names
        % with their AdjMat indices.
        HashMap
        
    end
    
    
    % SETTERS AND GETTERS
    methods
        
        function n = get.NumEdges(obj)
            %GET.NUMEDGES Getter for NumEdges.
            % Auto-calculated using NNZ on the AdjMat.
            n = nnz(obj.AdjMat);
        end
        
        function n = get.NumVertices(obj)
            %GET.NUMVERTICES Getter for NumVertices.
            % Auto-calculated using the Count of the HashMap object.
            n = double(obj.HashMap.Count);
            % Use DOUBLE since Count will return a uint64 type.
        end
        
    end
    
    
    methods (Access = public)
        
        function obj = digraph()
            %DIGRAPH creates an empty DIGRAPH object.
            %  Example:
            %   dg = DIGRAPH
            reset(obj);
        end
        
    end
    
    
    methods (Access = protected)
        
        cp = copyElement(obj)
        
        ind = vert2ind(obj,v)
        
    end
    
end