function p = dijkstra(A,source,target)
% Private function to digraph

%DIJKSTRA Dijkstra's algorithm for shortest path.
% P = DIJKSTRA(A,SOURCE,TARGET) for sparse boolean Adjacency Matrix A and
% indices SOURCE and TARGET, returns the indexed shortest path P.
%
% P is empty if there is no path from SOURCE to TARGET, or in the trivial
% case that SOURCE == TARGET.
% If P is not empty, then P(1) == SOURCE.

% See http://en.wikipedia.org/wiki/Dijkstra's_algorithm

p = []; %path to return
N = length(A);
dist = inf(1,N); %dist(i) represents the shortest distance from source to i
prev = zeros(1,N); %sequence of shortest path from point to point
Q = 1:N; %represents the pool of vertices yet to be tested

dist(source) = 0;

for k=1:N
    [~,i] = min(dist(Q));
    u = Q(i);
    if u == target || isinf(dist(u))
        % Either we hit the target and we're done, or all remaining
        % vertices are inaccessible from source so there's no sense
        % continuing
        break
    end
    
    % Pop out the u value (indexing is faster than SETDIFF).
    % Length of Q is shortened by 1 each time.
    Q = Q([1:i-1, i+1:N-k+1]);
    
    % test if there is a cheaper alternate path
    alt = dist(u) + 1;
    f = find(A(u,:));
    v = f( alt < dist(f) );
    dist(v) = alt;
    prev(v) = u;
end

% Reconstruct the path
u = target;
while prev(u) ~= 0
    p = [u p]; %#ok<AGROW>
    u = prev(u);
end

% Append the source if the target was hit
if ~isempty(p) || k==1
    p = [source p];
end