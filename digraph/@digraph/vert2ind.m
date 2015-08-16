function I = vert2ind(obj,V)
%VERT2IND Maps vertices to indices corresponding to Vertex and AdjMat.
% I = VERT2IND(DG,V) returns a vector of indices that correspond with the
% cell array of vertices V.
% This guarantees the relationship
%
%       V = dg.Vertex(I)   and   I = vert2ind(dg,V)
%
% Errors if the vertex does not exist.
%
% See also Vertex, addEdge, hasEdge.

% Copyright 2013-2014 The MathWorks, Inc.

try
    I = cellfun(@double,values(obj.HashMap,V));
catch me
    % let assertVertex now handle the error messaging for bad
    % vertices, whichever may have thrown the exception
    for k=1:numel(V)
        obj.assertVertex(V{k});
    end
    % if we made it this far, something else went wrong
    rethrow(me)
end