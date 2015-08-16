function spy(obj,varargin)
%SPY Visualize sparsity pattern of AdjMat
% SPY(DG) plots the sparsity pattern of DG's AdjMat.
% SPY(DG,...) passes LineSpec or MarkerSize on to built-in SPY function.
%
% By clicking on datapoints in the plot, a datatip will display what edge
% it represents with the text "V1 -> V2" for vertices V1 and V2.
%
% See also SPY.

% Copyright 2014 The MathWorks, Inc.

V = obj.Vertex;
arrow = char(8594); % unicode right-arrow
thresh = 50;

% use builtin
spy(obj.AdjMat,varargin{:});

% data tips
dcm_obj = datacursormode(gcf);
set(dcm_obj,'UpdateFcn',@customtext,'Enable','on')

    function txt = customtext(~,e)
        % Customizes text of data tips
        
        pos = get(e,'Position');
        v1 = V{pos(1)};
        v2 = V{pos(2)};
        
        if length(v1) + length(v2) > thresh
            % long labels, split into two rows
            txt = {v2,[arrow ' ' v1]};
        else
            % one-liner
            txt = {[v2 ' ' arrow ' ' v1]};
        end
        
    end

end