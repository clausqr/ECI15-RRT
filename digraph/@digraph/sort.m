function [sorted, perm] = sort(obj)
%SORT Sort the Vertices by their labels.
% B = SORT(A) for digraph A returns a digraph B that ISEQUIVALENT to A, but
%           has its Vertices sorted. This may affect the underlying AdjMat.
% [B, I] = SORT(A) additionally returns the permutation vector I, such that
%           B.Vertex == A.Vertex(I).
%
% See also ISEQUIVALENT.

% Copyright 2014 The MathWorks, Inc.

sorted = copy(obj);

% early return if there is nothing to sort
if isempty(obj), return, end

% use built-in SORT function on the cell array
[sortedV,perm] = sort(obj.Vertex);

% set Vertex to sorted cell array
sorted.Vertex = sortedV;

% set AdjMat using perm vectors on both rows and cols
sorted.AdjMat = sorted.AdjMat(perm,perm);

% set HashMap using a new containers.Map(KEYS,VALUES) constructor
sorted.HashMap = containers.Map(sortedV,1:sorted.NumVertices);