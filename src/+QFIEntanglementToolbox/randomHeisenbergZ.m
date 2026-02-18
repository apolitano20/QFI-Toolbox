function varargout = randomHeisenbergZ(varargin)
%RANDOMHEISENBERGZ Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.hamiltonians.randomHeisenbergZ.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.hamiltonians.randomHeisenbergZ(varargin{:});
else
    QFIEntanglementToolbox.hamiltonians.randomHeisenbergZ(varargin{:});
end
end
