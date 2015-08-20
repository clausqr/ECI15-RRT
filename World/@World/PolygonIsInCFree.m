function isIt = PolygonIsInCFree(obj, a)
    % POLYIGONISINCFREE Checks if a Polygon is in C_free of the Obstacle Map of the world object.
    %   ISIT = POLYIGONISINCFREE(A) Checks if a Polygon A is in C_free of 
    %   the Obstacle Map of the world object, and returns ISIT = true if it
    %   is and ISIT = false if it isn't.
    %   Polygon A is a 2xN matrix with N vertices as pairs of x,y values
    %   stacked, i.e.
    %       A = [x1 x2 ... xn;
    %            y1 y2 ... yn];
    %
    % (c) https://github.com/clausqr for ECI2015    

% Checks if polygon defined in a is in CFree of current world Obstacle Map.
% Only take x and y coordinates, discard z.
xi = ceil(obj.nx*a(1, :));
yi = ceil(obj.ny*a(2, :));

xi = checkBounds(xi, obj.nx);
yi = checkBounds(yi, obj.ny);

c = improfile(obj.ObstacleMap, xi, yi);

p1 = sum(c,3);

p = max(p1) - p1;

t = sum(p);

if (t == 0)
    isIt = true;
else
    isIt = false;
end

end

function y = checkBounds(x, n)


x1 = (x>0).*x + 1.*(x<=0);
y =  (x1<=n).*x1 + n.*(x1>n);

end
