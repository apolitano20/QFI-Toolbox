function varargout = entropy(varargin)
%ENTROPY Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.entropy instead.

qfiDeprecatedRootApi('entropy', 'QFIEntanglementToolbox.entropy');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.entropy(varargin{:});
else
    QFIEntanglementToolbox.entropy(varargin{:});
end
end
