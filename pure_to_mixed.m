function varargout = pure_to_mixed(varargin)
%PURE_TO_MIXED Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.pureToMixed instead.

qfiDeprecatedRootApi('pure_to_mixed', 'QFIEntanglementToolbox.pureToMixed');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.pureToMixed(varargin{:});
else
    QFIEntanglementToolbox.pureToMixed(varargin{:});
end
end
