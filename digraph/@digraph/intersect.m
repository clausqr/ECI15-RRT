function result = intersect(obj1,obj2)
%INTERSECT Combine two digraphs with vertices and edges in both graphs.
% C = INTERSECT(A,B) returns a digraph containing the intersection of
% vertices from digraphs A and B, with an edge between vertices V1 and V2
% if they have edges in both digraphs.
%  Example:
%   dgIntersect = INTERSECT(dg1,dg2)
%
% See also UNION.

% Copyright 2013-2014 The MathWorks, Inc.

% check inputs
if ~isa(obj1,'digraph') || ~isa(obj2,'digraph')
    error(MsgCatalog('MATLAB:digraph:badinputclass'));
end

% start blank and add to it
result = copy(obj1);
reset(result);

v = intersect(obj1.Vertex,obj2.Vertex);
N = numel(v);

if N==0, return, end

% set properties explicitly
result.Vertex = v;
result.HashMap = containers.Map(v,1:N);

% cache vertex-to-index lookups
idx1 = vert2ind(obj1,v);
idx2 = vert2ind(obj2,v);

% Take the intersection of the blocks
result.AdjMat = double( obj1.AdjMat(idx1,idx1) & obj2.AdjMat(idx2,idx2) );
