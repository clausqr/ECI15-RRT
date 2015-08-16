function cp = copyElement(obj)
%COPYELEMENT Override protected matlab.mixin.Copyable
% copyElement method. This makes the public method COPY do the right thing.
%  Example:
%   c = COPY(dg)

% Copyright 2013-2014 The MathWorks, Inc.

% Let matlab.mixin.Copyable do its magic
cp = copyElement@matlab.mixin.Copyable(obj);

% Deep copy for the HashMap handle object
if isempty(cp)
    % Map contructor errors with empty keys
    cp.HashMap = containers.Map();
else
    h = obj.HashMap;
    cp.HashMap = containers.Map(keys(h),values(h));
end