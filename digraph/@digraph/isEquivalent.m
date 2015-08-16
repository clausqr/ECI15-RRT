function tf = isEquivalent(obj1,obj2)
%ISEQUIVALENT True if digraphs have same vertices and edges.
% This is much stricter than maybe an "isSameEquivalentClass" in the sense
% of true graph theory. This just assures both graphs have the same vertex
% labels and the correct edges between them. For example, the two graphs
%               A -> B -> C    and     B -> A -> C
% have the same structure in a graph theory sense, but since we are
% actively using vertex labels, this would not be equivalent.
%  Example:
%   tf = ISEQUIVALENT(dg1,dg2)

% Copyright 2013-2014 The MathWorks, Inc.

% check inputs
if ~isa(obj1,'digraph') || ~isa(obj2,'digraph')
    error(MsgCatalog('MATLAB:digraph:badinputclass'));
end

% match size
if obj1.NumVertices ~= obj2.NumVertices
    tf = false;
    return
end

sorted1 = sort(obj1);
sorted2 = sort(obj2);

% match vertices
if ~all(strcmp(sorted1.Vertex,sorted2.Vertex))
    tf = false;
    return
end

% match edges
tf = full(all(all(sorted1.AdjMat == sorted2.AdjMat))); % reduce to 1x1 logical
