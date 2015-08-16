function reset(obj)
%RESET Reset DIGRAPH to a default state.
%  Example:
%   dg = digraph;
%   addVertex(dg,'foo')
%   RESET(dg)
%   hasVertex(dg,'foo') % false

% Copyright 2013-2014 The MathWorks, Inc.

obj.AdjMat = sparse([],[],[],0,0,false);
obj.Vertex = [];
obj.HashMap = containers.Map('KeyType','uint32', 'ValueType','any');