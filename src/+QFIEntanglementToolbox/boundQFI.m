function varargout = boundQFI(varargin)
%BOUNDQFI Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.entanglement.boundQFI.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.entanglement.boundQFI(varargin{:});
else
    QFIEntanglementToolbox.entanglement.boundQFI(varargin{:});
end
end
