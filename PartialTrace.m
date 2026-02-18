function varargout = PartialTrace(varargin)
%PARTIALTRACE Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.PartialTrace instead.

qfiDeprecatedRootApi('PartialTrace', 'QFIEntanglementToolbox.PartialTrace');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.PartialTrace(varargin{:});
else
    QFIEntanglementToolbox.PartialTrace(varargin{:});
end
end
