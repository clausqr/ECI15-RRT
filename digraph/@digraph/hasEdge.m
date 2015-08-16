function [tf, row, col] = hasEdge(obj, tail, head)
%HASEDGE Determine if an edge exists between vertices.
% TF = HASEDGE(DG,TAIL,HEAD) returns true if TAIL points to HEAD in the
% digraph DG.
% [TF,ROW,COL] = HASEDGE(DG,TAIL,HEAD) will additionally return the
% corresponding row/col indices in the Adjacency Matrix.
%
% Errors if vertices do not exist.
%
%  Example:
%   [tf,row,col] = HASEDGE(dg,'Cause_D','Effect_B')
%
% See also ADDEDGE, REMOVEEDGE.

% Copyright 2013-2014 The MathWorks, Inc.

idx = vert2ind(obj,{tail,head});
row = idx(1);
col = idx(2);
tf = logical(full(obj.AdjMat(row,col))); % 1x1 logical