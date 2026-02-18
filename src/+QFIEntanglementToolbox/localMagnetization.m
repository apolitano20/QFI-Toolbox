function varargout = localMagnetization(varargin)
%LOCALMAGNETIZATION Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.entanglement.localMagnetization.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.entanglement.localMagnetization(varargin{:});
else
    QFIEntanglementToolbox.entanglement.localMagnetization(varargin{:});
end
end
