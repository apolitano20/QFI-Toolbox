function varargout = localMagnetization(varargin)
%LOCALMAGNETIZATION Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.localMagnetization instead.

qfiDeprecatedRootApi('localMagnetization', 'QFIEntanglementToolbox.localMagnetization');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.localMagnetization(varargin{:});
else
    QFIEntanglementToolbox.localMagnetization(varargin{:});
end
end
