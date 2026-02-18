function varargout = orderParameter(varargin)
%ORDERPARAMETER Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.orderParameter instead.

qfiDeprecatedRootApi('orderParameter', 'QFIEntanglementToolbox.orderParameter');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.orderParameter(varargin{:});
else
    QFIEntanglementToolbox.orderParameter(varargin{:});
end
end
