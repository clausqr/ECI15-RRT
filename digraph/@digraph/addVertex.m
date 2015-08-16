function addVertex(obj, v)
%ADDVERTEX Add a vertex to the graph.
% ADDVERTEX(DG,V) adds one vertex with the label V to the graph. No effect
% if the vertex already exists.
%  Example:
%   ADDVERTEX(dg,'Philadelphia')
%
% See also REMOVEVERTEX, HASVERTEX, ASSERTVERTEX.

% Copyright 2013-2014 The MathWorks, Inc.

if ~hasVertex(obj,v)
    % pad with zero col and row to avoid illegal accesses
    obj.AdjMat = blkdiag(obj.AdjMat,0);
    
    N = obj.NumVertices+1;
    obj.Vertex{N} = v;
    obj.HashMap(v) = N;
end