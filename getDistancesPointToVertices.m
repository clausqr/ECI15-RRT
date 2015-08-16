%getDistancesPointToVertices
%
% https://github.com/clausqr

function d = getDistancesPointToVertices(vertices, point)


    rays = bsxfun(@minus, vertices, point);
    
    d = arrayfun(@(idx) norm(rays(:,idx)),...
        1:size(rays,2));