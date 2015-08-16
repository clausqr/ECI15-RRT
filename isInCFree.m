function isIt = isInCFree(M, a)

[ny, nx, nz] = size(M);

% Only take x and y coordinates, discard z.
xi = ceil(nx*a(1, :));
yi = ceil(ny*a(2, :));

xi = checkBounds(xi, nx);
yi = checkBounds(yi, ny);

c = improfile(M, xi, yi);

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
