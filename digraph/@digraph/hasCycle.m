function tf = hasCycle(obj)
%HASCYCLE Determine if the graph contains a "Cycle".
% Returns true if any vertex has a path to itself.
%  Example:
%   tf = HASCYCLE(dg)
%
% See also HASPATH, TRANSITIVECLOSURE.

% Copyright 2013-2014 The MathWorks, Inc.

tc = transitiveClosure(obj);
% if any vertex points to itself, we know it must be part of a
% cycle
tf = any(spdiags(tc.AdjMat,0));