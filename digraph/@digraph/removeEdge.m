function removeEdge(obj, tail, head)
%REMOVEEDGE Remove an edge between vertices in the graph.
% REMOVEEDGE(DG,TAIL,HEAD) removes the edge from TAIL onto HEAD vertices.
% Errors if vertices do not exist. No effect if there is already no edge
% present.
%  Example:
%   REMOVEEDGE(dg,'Correlation','Causation')
%
% See also ADDEDGE, HASEDGE.

% Copyright 2013-2014 The MathWorks, Inc.

idx = vert2ind(obj,{tail,head});
obj.AdjMat(idx(1),idx(2)) = 0;