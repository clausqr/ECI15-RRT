%% Manipulating digraphs with Vertex labels
% Copyright 2013-2014 The MathWorks, Inc.

%%
% Many directed graph, or *digraph*, applications drop the vertex labels to
% focus on computations of the Adjacency Matrix, referring to the vertices
% only by their indices. The |digraph| class attempts to provide a
% convenient interface for those that require to know what the vertex
% actually represents.

%%
% This is a quick introduction to how to get started using |digraph|, but
% executing
%
%   help digraph
% 
% will provide links to read about more in-depth functionality, while
%
%   methods digraph
%
% lists all valid functions that can be used with the digraph.

%% Construct a new digraph
% Start by creating a blank digraph object:
dg = digraph

%% Vertices
% Add vertex labels to the digraph. The labels must be strings.
addVertex(dg,'A')
addVertex(dg,'B')
addVertex(dg,'C')
addVertex(dg,'D')
addVertex(dg,'E')
addVertex(dg,'F')
addVertex(dg,'G')
addVertex(dg,'H')
addVertex(dg,'I')
addVertex(dg,'J')
addVertex(dg,'K')

%% Edges
% To represent an edge from _A_ onto _B_, the syntax is predictably
addEdge(dg,'A','B')
%%
% Add others one at a time:
addEdge(dg,'B','I')
addEdge(dg,'C','D')
addEdge(dg,'D','I')
addEdge(dg,'I','E')
addEdge(dg,'E','F')
addEdge(dg,'I','F')
addEdge(dg,'I','G')
addEdge(dg,'G','H')
addEdge(dg,'F','K')
%%
% Now our digraph is something substantial:
dg

%% Adjacency Matrix
% The Adjacency Matrix, shortened to *|AdjMat|*, is a matrix representation
% of the edges. |AdjMat|(_i_, _j_) is true if and only if there is an edge
% from vertex _i_ to vertex _j_.
%
% Thus the following are equivalent, either using the succinct |hasEdge|
% function:
hasEdge(dg,'A','B')
%%
% Or by using Vertex indices to access the |AdjMat| directly:
[foundA,i] = hasVertex(dg,'A');
[foundB,j] = hasVertex(dg,'B');
if foundA && foundB % make sure they were each found
    edge = dg.AdjMat(i,j)
end

%%
% See <matlab:doc('assertVertex') assertVertex> for a stricter
% version of |hasVertex| and <matlab:doc('removeVertex')
% removeVertex> to learn more about accessing indices directly. Using the
% indices is a more advanced maneuver, to be used only when it is more
% convenient. The beauty of the digraph implementation is that you
% *don't* (and shouldn't!) have to track the corresponding index.

%%
% As gleened from the output above, the |AdjMat| is stored as a
% <matlab:doc('sparse') sparse> matrix, whose display can be hard to read:
dg.AdjMat
%%
% View it as a full matrix by using <matlab:doc('full') full>. This is
% *not* advised for large matrices for the sake of memory.
full(dg.AdjMat)

%% Subgraphs
% Create subgraphs of your digraph by specifying the vertices. This will
% return a new digraph:
subgraph(dg,{'C','D','G','H'})

%% Finding Edges
% Find all vertices that _I_ directly (explicitly) points to:
findall(dg,'I',1)
%%
% and those that directly point to _I_:
findall(dg,'I',-1)
%%
% Find all vertices that _I_ directly or indirectly (implicitly) points to:
findall(dg,'I',Inf)
%%
% and those that directly or indirectly point to _I_:
findall(dg,'I',-Inf)
%%
% Find all vertices that are at most 3 edges "ahead" of _A_:
findall(dg,'A',3)

%%
% |findall| will always return a _sorted_ cell array.

%% Finding Paths
% See if two vertices are linked by an edge directly:
hasEdge(dg,'A','K')
%%
% or indirectly.
hasPath(dg,'A','K')
%%
% Find the shortest path from one to the other. This implements Dijkstra's
% algorithm.
shortestPath(dg,'A','K')

%%
% |P = *shortestPath*(DG,SOURCE,TARGET)| will return a _sequential_ cell
% array |P|. If |hasPath| from |SOURCE| to |TARGET| returns false, then |P|
% will be empty, otherwise |P| will have a sequence of vertex names such
% that
%
% |SOURCE = P{1} $\rightarrow$ P{2} $\rightarrow \cdots \rightarrow$
% P{end} = TARGET|.

%%
% If |SOURCE| and |TARGET| are the same, |hasPath| will always return true
% and |shortestPath| will have exactly one element.

%% Union, Intersect, and Copy
% Combine and copy entire digraphs:
c = copy(dg)

%%
% This makes a "deep" copy, such that |dg| and |c| are completely
% independent:
addVertex(c,'foo')
hasVertex(c,'foo') % c should contain "foo"
hasVertex(dg,'foo') % dg should NOT contain "foo"

%%
% Taking the *union* of |dg| and |c| will use the union of the vertices and
% the edges available in _either_ digraph:
union(dg,c)

%%
% Taking the *intersect* of |dg| and |c| will use the intersect of the
% vertices and the edges between them that are found in _both_ digraphs:
intersect(dg,c)

%% Transitive Closure
% The transitive closure of a digraph makes all implicit edges explicit. In
% other words, if you have that _A_ $\rightarrow$ _B_ $\rightarrow$ _C_,
% then _C_ is in _A_'s transitive closure. The |transitiveClosure| function
% will create a new digraph with an additional edge from _A_ onto _C_.

%%
% Here, notice how |NumEdges| grows to 35:
tc = transitiveClosure(dg)

%%
% The original digraph will be a subset of its transitive closure:
isEquivalent(tc, union(dg,tc))
%%
isEquivalent(dg, intersect(dg,tc))

%% Minimal Edges
% This is in a sense the converse of |transitiveClosure|. If you have that
% _A_ $\rightarrow$ _B_ $\rightarrow$ _C_ and _A_ $\rightarrow$ _C_, then
% the edge from _A_ onto _C_ is redundant since there is already an
% indirect edge through _B_. The |minimalEdges| function will create a new
% digraph that has the edge from _A_ onto _C_ removed.

%%
% Here, notice how |NumEdges| shrinks to 9:
me = minimalEdges(dg)

%%
% This will (conversely to the transitive closure) be a subset of the
% original:
isEquivalent(dg, union(dg,me))
%%
isEquivalent(me, intersect(dg,me))
