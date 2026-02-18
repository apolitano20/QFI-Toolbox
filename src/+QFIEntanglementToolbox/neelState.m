function varargout = neelState(varargin)
%NEELSTATE Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.states.neelState.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.states.neelState(varargin{:});
else
    QFIEntanglementToolbox.states.neelState(varargin{:});
end
end
