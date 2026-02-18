function varargout = stateEvolution(varargin)
%STATEEVOLUTION Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.states.stateEvolution.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.states.stateEvolution(varargin{:});
else
    QFIEntanglementToolbox.states.stateEvolution(varargin{:});
end
end
