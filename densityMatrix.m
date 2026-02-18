function varargout = densityMatrix(varargin)
%DENSITYMATRIX Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.densityMatrix instead.

qfiDeprecatedRootApi('densityMatrix', 'QFIEntanglementToolbox.densityMatrix');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.densityMatrix(varargin{:});
else
    QFIEntanglementToolbox.densityMatrix(varargin{:});
end
end
