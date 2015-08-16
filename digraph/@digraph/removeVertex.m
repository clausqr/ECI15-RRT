function removeVertex(obj, v)
%REMOVEVERTEX Remove a vertex from the graph.
% REMOVEVERTEX(DG,V) Removes the vertex with label V from the
% graph.
%  Example:
%   REMOVEVERTEX(dg,'Honolulu')
%
% Fastest execution is achieved by inserting the "last" vertex into the old
% slot, making this O(1) time. Therefore if you have
%
% v1 = dg.Vertex{dg.NumVertices}
% v2 = dg.Vertex{dg.NumVertices-1}
% [~, idx] = hasVertex(dg,'somewhereInTheMiddle')
% REMOVEVERTEX(dg,'somewhereInTheMiddle')
% v3 = dg.Vertex{idx}
% v4 = dg.Vertex{dg.NumVertices}
%
%  Then v1==v3 and v2==v4.
%
% It is not advised to rely on indices, as these may change underneath.
% Always re-get the values before using.
%
% See also ADDVERTEX, HASVERTEX, ASSERTVERTEX.

% Copyright 2013-2014 The MathWorks, Inc.

% Copy and replace
idx = assertVertex(obj,v);
N = obj.NumVertices;
AM = obj.AdjMat;
AM(idx,:) = AM(N,:); % copy row over
AM(:,idx) = AM(:,N); % copy col over
obj.Vertex{idx} = obj.Vertex{N};
obj.HashMap(obj.Vertex{idx}) = idx;

% Pop off vertex and true-up
remove(obj.HashMap,v);
N = N-1;
obj.AdjMat = AM(1:N,1:N);
obj.Vertex = obj.Vertex(1:N);
