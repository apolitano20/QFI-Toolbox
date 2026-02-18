function varargout = traceDistance(varargin)
%TRACEDISTANCE Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.traceDistance instead.

qfiDeprecatedRootApi('traceDistance', 'QFIEntanglementToolbox.traceDistance');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.traceDistance(varargin{:});
else
    QFIEntanglementToolbox.traceDistance(varargin{:});
end
end
