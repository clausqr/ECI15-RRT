function result = union(obj1,obj2)
%UNION Combine two digraphs with vertices and edges in either graph.
% C = UNION(A,B) returns a digraph containing the union of vertices from
% digraphs A and B, with an edge between vertices V1 and V2 if they have
% edges in either digraphs.
%  Example:
%   dgUnion = UNION(dg1,dg2)
%
% See also INTERSECT.

% Copyright 2013-2014 The MathWorks, Inc.

% check inputs
if ~isa(obj1,'digraph') || ~isa(obj2,'digraph')
    error(MsgCatalog('MATLAB:digraph:badinputclass'));
end

% start blank and add to it
result = copy(obj1);
reset(result);

% store vertices in different groupings
v1 = obj1.Vertex;
v2 = obj2.Vertex;
vU = union(v1,v2);
N = numel(vU);

if N==0, return, end

% set properties explicitly
result.Vertex = vU;
result.HashMap = containers.Map(vU,1:N);

% cache AdjMat accesses
A = result.AdjMat; % already empty
A1 = obj1.AdjMat;
A2 = obj2.AdjMat;

% add V1 edges
idx = vert2ind(result,v1);
idxToAdd = vert2ind(obj1,v1);
A(idx,idx) = A1(idxToAdd,idxToAdd);

% add V2 edges (might overwrite V1 edges)
idx = vert2ind(result,v2);
idxToAdd = vert2ind(obj2,v2);
A(idx,idx) = A2(idxToAdd,idxToAdd);

% add intersection
vI = intersect(v1,v2);
idx = vert2ind(result,vI);
idx1 = vert2ind(obj1,vI);
idx2 = vert2ind(obj2,vI);

% Take the union of the blocks
A(idx,idx) = double( A1(idx1,idx1) | A2(idx2,idx2) );

result.AdjMat = A;
