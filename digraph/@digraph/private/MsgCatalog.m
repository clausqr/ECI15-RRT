function e = MsgCatalog(ID,varargin)
% Private function to digraph

%MSGCATALOG Private error message catalog for DIGRAPH

% Copyright 2014 The MathWorks, Inc.

e.identifier = ID;

switch ID
    case 'MATLAB:digraph:badinputclass'
        e.message = 'Input must be digraph objects.';
        
    case 'MATLAB:digraph:badinputtype'
        e.message = sprintf('Input must be a %s.',varargin{:});
    
    case 'MATLAB:digraph:invalidvertexlabel'
        e.message = 'Vertex labels must be strings.';
    
    case 'MATLAB:digraph:nosuchvertex'
        e.message = sprintf(...
            'Vertex "%s" not found in the graph.',varargin{:});
        
    otherwise
        error('Error ID "%s" not found.',ID);
end