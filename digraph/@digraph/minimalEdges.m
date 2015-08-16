function dgThin = minimalEdges(obj)
%MINIMALEDGES Prune redundant edges.
% dgThin = MINIMALEDGES(DG) returns a digraph with minimal edges while
% retaining all the indirect edges of DG. ie, if X->Y->Z then X->Z would be
% redundant and therefore removed.
%
%  Example:
%   dgThin = MINIMALEDGES(dg)
%
% In the case that the digraph ISCOMPLETE, there is no unique way to prune
% the edges on the resulting graph (consider the complete graph with the
% structure A <-> B <-> C <-> A). Only self-directed edges are removed.
%
% See also TRANSITIVECLOSURE, ISCOMPLETE.

% Copyright 2013-2014 The MathWorks, Inc.

dgThin = copy(obj);
if obj.NumEdges==0, return, end

dgFull = transitiveClosure(obj);
A = dgThin.AdjMat;
tc = dgFull.AdjMat;
N = obj.NumVertices;

% zero-out diagonals: self-directed vertices are immediately redundant
emptyCol = sparse(N,1);
A = spdiags(emptyCol,0,A);

if isComplete(dgFull)
    % Just stop at the removal the self-loops. There is no elegant or
    % unique way to prune the edges.
    dgThin.AdjMat = A;
    return
end

for x=1:N
    % Find everything that x indirectly points to
    y = tc(x,:)>0;
    for z=find(A(x,:))
        % Remove edge A(x,z) if any y indirectly points to z.
        if any(tc(y,z))
            A(x,z) = 0; %#ok<SPRIX>
        end
    end
end

dgThin.AdjMat = A;