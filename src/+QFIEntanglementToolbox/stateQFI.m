function varargout = stateQFI(varargin)
%STATEQFI Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.qfi.stateQFI.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.qfi.stateQFI(varargin{:});
else
    QFIEntanglementToolbox.qfi.stateQFI(varargin{:});
end
end
