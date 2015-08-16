function tf = hasPath(obj,source,target)
%HASPATH Determine if there exists a path between vertices.
% HASPATH(DG,SOURCE,TARGET) returns true if there exists a path from SOURCE
% to TARGET.
% Always returns true in the trivial case, SOURCE == TARGET.
% Errors if either do not exist in the graph.
%
%  Example:
%   if HASPATH(dg,'Shire','Mordor')
%       % simply walk
%       ...
%   end
%
% See also SHORTESTPATH.

% Copyright 2013-2014 The MathWorks, Inc.

tf = ~isempty(shortestPath(obj,source,target));