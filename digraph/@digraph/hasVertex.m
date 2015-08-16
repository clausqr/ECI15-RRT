function [tf, idx] = hasVertex(obj, v)
%HASVERTEX Determine if a vertex exists in a graph.
% TF = HASVERTEX(DG,V) returns true if DG contains the vertex V.
% [TF,I] = HASVERTEX(DG,V) additionally returns the corresponding index in
% the Vertex and Adjacency Matrix properties. If the boolean result TF is
% false, the index I returned will default to zero.
%  Example:
%   [tf,idx] = HASVERTEX(dg,'Jamestown')
%
% See also ADDVERTEX, REMOVEVERTEX, ASSERTVERTEX.

% Copyright 2013-2014 The MathWorks, Inc.

% if ~ischar(v)
%     error(MsgCatalog('MATLAB:digraph:invalidvertexlabel'))
% end

idx = 0;
tf = isKey(obj.HashMap,v);
if tf % faster than try/catch block and VERT2IND
    idx = obj.HashMap(v);
end
