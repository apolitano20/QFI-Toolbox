function varargout = TensorSum(varargin)
%TENSORSUM Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.tensorSum instead.

qfiDeprecatedRootApi('TensorSum', 'QFIEntanglementToolbox.tensorSum');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.tensorSum(varargin{:});
else
    QFIEntanglementToolbox.tensorSum(varargin{:});
end
end
