function idx = assertVertex(obj,v)
%ASSERTVERTEX Assert that a vertex exists in the graph.
% More strict than HASVERTEX, erroring if specified vertex does not exist,
% otherwise returning the (non-zero) index value.
%  Example:
%   [tf,idx] = hasVertex(dg,v)
%   if ~tf
%      error('No such vertex')
%   else % idx guaranteed >0
%      row = dg.AdjMat(idx,:); % won't error
%   end
%
%  is functionally equivalent to:
%
%   idx = ASSERTVERTEX(dg,v);
%   % idx guaranteed >0
%   row = dg.AdjMat(idx,:); % won't error
%
% See also ADDVERTEX, REMOVEVERTEX, HASVERTEX.

% Copyright 2013-2014 The MathWorks, Inc.

[tf,idx] = hasVertex(obj,v);
if ~tf
    error(MsgCatalog('MATLAB:digraph:nosuchvertex',v))
end