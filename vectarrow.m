function varargout = vectarrow(varargin)
%VECTARROW Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.vectArrow instead.

qfiDeprecatedRootApi('vectarrow', 'QFIEntanglementToolbox.utils.vectArrow');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.vectArrow(varargin{:});
else
    QFIEntanglementToolbox.utils.vectArrow(varargin{:});
end
end
