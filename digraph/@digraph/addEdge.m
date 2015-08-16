function addEdge(obj, tail, head)
%ADDEDGE Add an edge between vertices in the graph.
% ADDEDGE(DG,TAIL,HEAD) adds an edge from TAIL onto HEAD vertices. Errors
% if vertices do not exist. No effect if there is already an edge present.
%  Example:
%   ADDEDGE(dg,'Fire','Oxygen')
%
% See also REMOVEEDGE, HASEDGE.

% Copyright 2013-2014 The MathWorks, Inc.

idx = vert2ind(obj,{tail,head});
obj.AdjMat(idx(1),idx(2)) = 1;