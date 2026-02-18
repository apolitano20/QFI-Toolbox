function varargout = stateQFImanual(varargin)
%STATEQFIMANUAL Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.stateQFIManual instead.

qfiDeprecatedRootApi('stateQFImanual', 'QFIEntanglementToolbox.stateQFIManual');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.stateQFIManual(varargin{:});
else
    QFIEntanglementToolbox.stateQFIManual(varargin{:});
end
end
