function PlotEdge(varargin)

vertices = varargin{1};
edge = varargin{2};
if (nargin == 4)
    s = varargin{3};
    t = varargin{4};
else
    s = 'LineWidth';
    t = 2;
end

    a = edge(1);
    b = edge(2);
    
    u = vertices(:, a);
    v = vertices(:, b);
    
    line([u(1) v(1)], [u(2) v(2)], s, t)





