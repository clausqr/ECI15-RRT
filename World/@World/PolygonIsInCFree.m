function isIt = PolygonIsInCFree(obj, a)

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
