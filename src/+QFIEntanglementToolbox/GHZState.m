function varargout = GHZState(varargin)
%GHZSTATE Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.states.GHZState.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.states.GHZState(varargin{:});
else
    QFIEntanglementToolbox.states.GHZState(varargin{:});
end
end
