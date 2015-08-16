function vList = shortestPath(obj,source,target)
%SHORTESTPATH Use Dijkstra's algorithm to find shortest path.
% P = SHORTESTPATH(SOURCE,TARGET) returns the shortest cell
% array P such that
%    SOURCE == P{1} -> P{2} -> ... -> P{end} == TARGET.
%
% If there is no path from source to target, then P is empty. P is exactly
% one element in the trivial case where SOURCE coincides with TARGET.
% Errors if either do not exist in the graph.
%
%  Example:
%   p = SHORTESTPATH(dg,'Entry-level','CEO')
%
% See also HASPATH.

% Copyright 2013-2014 The MathWorks, Inc.

I = vert2ind(obj,{source,target});
p = dijkstra(obj.AdjMat,I(1),I(2));
vList = obj.Vertex(p);