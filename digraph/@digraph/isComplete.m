function tf = isComplete(obj)
%ISCOMPLETE Determine if a graph is "Complete".
% Returns true if each vertex points to every other vertex, except possibly
% itself. Transitive closure is *not* implicitly called to allow the user
% to decide and leverage for performance.
%  Example:
%   tf = ISCOMPLETE(dg)
%
% See also TRANSITIVECLOSURE.

% Copyright 2013-2014 The MathWorks, Inc.

A = obj.AdjMat;
numNonSelfEdges = obj.NumEdges - sum(spdiags(A,0));
tf = numNonSelfEdges == numel(A)-obj.NumVertices;