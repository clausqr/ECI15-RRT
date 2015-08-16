function dgFull = transitiveClosure(obj)
%TRANSITIVECLOSURE Take the Transitive Closure of the graph.
% dgFull = TRANSITIVECLOSURE(DG) returns the transitive closure of DG,
% making all indirect edges direct. ie, if X->Y and Y->Z, set explicitly
% that X->Z.
%  Example:
%   dgFull = TRANSITIVECLOSURE(dg)
%
% See also MINIMALEDGES.

% Copyright 2013-2014 The MathWorks, Inc.

dgFull = copy(obj);
A = dgFull.AdjMat;
N = obj.NumVertices;

for j=1:N
    % For each j:
    % Find all i such that A(i,j) true.
    % Find all k such that A(j,k) true.
    % Since i->j and j->k, then mark all i->k.
    A( A(:,j)>0, A(j,:)>0 ) = 1;
end

dgFull.AdjMat = A;