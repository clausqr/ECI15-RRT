function subgraph = subgraph(obj, vSubset)
%SUBGRAPH Create a subgraph containing a subset of vertices.
% SG = SUBGRAPH(DG,VSUBSET) returns a subgraph of digraph DG, only
% containing those vertices in VSUBSET and the explicit edges between them.
%  Example:
%   sg = SUBGRAPH(dg,{'height','weight','age'})

% Copyright 2013-2014 The MathWorks, Inc.

% Check inputs
if ~iscell(vSubset)
    error(MsgCatalog('MATLAB:digraph:badinputtype','cell array'));
end
if ~all(cellfun(@(x)isa(x,'char'),vSubset))
    error(MsgCatalog('MATLAB:digraph:invalidvertexlabel'));
end

% Use copy instead of digraph constructor to preserve class
subgraph = copy(obj);
reset(subgraph);

vSubset = unique(vSubset);
N = numel(vSubset);

if N==0, return, end

% cache vertex-to-index lookups while validating vertices
idx = vert2ind(obj,vSubset);

% set properties explicitly
subgraph.Vertex = vSubset;
subgraph.HashMap = containers.Map(vSubset,1:N);
subgraph.AdjMat = obj.AdjMat(idx,idx);
