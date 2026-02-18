function varargout = cleanMat(varargin)
%CLEANMAT Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.cleanMat instead.

qfiDeprecatedRootApi('cleanMat', 'QFIEntanglementToolbox.utils.cleanMat');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.cleanMat(varargin{:});
else
    QFIEntanglementToolbox.utils.cleanMat(varargin{:});
end
end
