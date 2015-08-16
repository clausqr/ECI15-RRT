function tf = isempty(obj)
%ISEMPTY True for empty digraph.
% ISEMPTY(DG) returns true if digraph DG is empty, meaning that it has no
% vertices.

% Copyright 2013-2014 The MathWorks, Inc.

% Checking NumVertices looks at the HashMap anyway
tf = isempty(obj.HashMap);