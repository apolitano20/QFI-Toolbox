function varargout = rhoQFI(varargin)
%RHOQFI Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.qfi.rhoQFI.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.qfi.rhoQFI(varargin{:});
else
    QFIEntanglementToolbox.qfi.rhoQFI(varargin{:});
end
end
