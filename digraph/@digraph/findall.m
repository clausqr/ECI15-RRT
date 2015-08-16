function [vList,I] = findall(obj,v,depth)
%FINDALL Find all vertices within a "depth" of a given vertex.
% VLIST = FINDALL(DG,V,DEPTH)
%  For positive DEPTH, finds those vertices that are at most DEPTH edges
%  "ahead" of V. For negative DEPTH, finds those vertices that are at most
%  DEPTH edges "behind" of V. DEPTH can be Inf or -Inf to find everything
%  ahead or behind V, respectively.
% [VLIST, I] = FINDALL(...) optionally returns the indices of the resulting
%  vertices.
%
% Examples:
%  V = FINDALL(dg,'foo',1) % vertices 'foo' explicitly points to.
%  V = FINDALL(dg,'foo',2) % vertices that 'foo' and the above results
%                            point to.
%  V = FINDALL(dg,'foo',Inf) % all vertices that 'foo' explicitly and
%                              implicitly points to.
%  V = FINDALL(dg,'foo',-1) % vertices that explicitly point to 'foo'.
%  V = FINDALL(dg,'foo',-2) % vertices that point to 'foo' and the above
%                             results.
%  V = FINDALL(dg,'foo',-Inf) % all vertices that explicitly and implicitly
%                               point to 'foo'.
%
% See also HASEDGE, SHORTESTPATH.

% Copyright 2014 The MathWorks, Inc.

idx = assertVertex(obj,v);

if ~isscalar(depth) || ~isnumeric(depth)
    error(MsgCatalog('MATLAB:digraph:badinputtype','scalar numeric'));
end

depth = round(depth);

if depth>0
    A = obj.AdjMat;
elseif depth<0
    A = obj.AdjMat';
else % NaN or zero
    I = [];
    vList = {};
    return
end

N = min(abs(depth),length(A));

[~,I] = find(A(idx,:));
for k=2:N
    [~,direct] = find(A(I,:));
    next = union(I,direct);
    if length(I) == length(next)
        % nothing more is accumulating
        break
    end
    I = next;
end

vList = obj.Vertex(I);
