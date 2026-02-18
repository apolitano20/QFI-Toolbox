function varargout = randomHeisenbergJ(varargin)
%RANDOMHEISENBERGJ Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.hamiltonians.randomHeisenbergJ.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.hamiltonians.randomHeisenbergJ(varargin{:});
else
    QFIEntanglementToolbox.hamiltonians.randomHeisenbergJ(varargin{:});
end
end
