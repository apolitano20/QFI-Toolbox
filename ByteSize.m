function varargout = ByteSize(varargin)
%BYTESIZE Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.ByteSize instead.

qfiDeprecatedRootApi('ByteSize', 'QFIEntanglementToolbox.utils.ByteSize');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.ByteSize(varargin{:});
else
    QFIEntanglementToolbox.utils.ByteSize(varargin{:});
end
end
