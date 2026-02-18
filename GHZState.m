function varargout = GHZState(varargin)
%GHZSTATE Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.GHZState instead.

qfiDeprecatedRootApi('GHZState', 'QFIEntanglementToolbox.GHZState');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.GHZState(varargin{:});
else
    QFIEntanglementToolbox.GHZState(varargin{:});
end
end
