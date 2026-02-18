function varargout = stateQFIManual(varargin)
%STATEQFIMANUAL Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.qfi.stateQFIManual.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.qfi.stateQFIManual(varargin{:});
else
    QFIEntanglementToolbox.qfi.stateQFIManual(varargin{:});
end
end
