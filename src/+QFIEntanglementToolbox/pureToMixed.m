function varargout = pureToMixed(varargin)
%PURETOMIXED Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.states.pureToMixed.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.states.pureToMixed(varargin{:});
else
    QFIEntanglementToolbox.states.pureToMixed(varargin{:});
end
end
