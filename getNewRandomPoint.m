function new_random_point = getNewRandomPoint(varargin)


if (nargin == 0)
    new_random_point = rand(3,1);
    new_random_point(3) = 0;
else
    mu = varargin{1};
    sigma = varargin{2};
    new_random_point = mu+chol(sigma)*randn(3,1);
    new_random_point(3) = 0;
end    
    
    
end
    