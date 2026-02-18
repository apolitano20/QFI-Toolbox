function varargout = TraceNorm(varargin)
%TRACENORM Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.traceNorm instead.

qfiDeprecatedRootApi('TraceNorm', 'QFIEntanglementToolbox.traceNorm');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.traceNorm(varargin{:});
else
    QFIEntanglementToolbox.traceNorm(varargin{:});
end
end
