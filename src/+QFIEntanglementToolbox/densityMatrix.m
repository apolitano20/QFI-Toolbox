function varargout = densityMatrix(varargin)
%DENSITYMATRIX Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.states.densityMatrix.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.states.densityMatrix(varargin{:});
else
    QFIEntanglementToolbox.states.densityMatrix(varargin{:});
end
end
