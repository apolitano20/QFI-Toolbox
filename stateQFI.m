function varargout = stateQFI(varargin)
%STATEQFI Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.stateQFI instead.

qfiDeprecatedRootApi('stateQFI', 'QFIEntanglementToolbox.stateQFI');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.stateQFI(varargin{:});
else
    QFIEntanglementToolbox.stateQFI(varargin{:});
end
end
