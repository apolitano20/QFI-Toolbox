function varargout = unique_perms(varargin)
%UNIQUE_PERMS Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.uniquePerms instead.

qfiDeprecatedRootApi('unique_perms', 'QFIEntanglementToolbox.utils.uniquePerms');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.uniquePerms(varargin{:});
else
    QFIEntanglementToolbox.utils.uniquePerms(varargin{:});
end
end
