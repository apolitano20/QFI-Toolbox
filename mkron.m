function varargout = mkron(varargin)
%MKRON Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.mKron instead.

qfiDeprecatedRootApi('mkron', 'QFIEntanglementToolbox.utils.mKron');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.mKron(varargin{:});
else
    QFIEntanglementToolbox.utils.mKron(varargin{:});
end
end
