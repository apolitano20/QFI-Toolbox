function varargout = heisenbergXXZ(varargin)
%HEISENBERGXXZ Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.hamiltonians.heisenbergXXZ.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.hamiltonians.heisenbergXXZ(varargin{:});
else
    QFIEntanglementToolbox.hamiltonians.heisenbergXXZ(varargin{:});
end
end
