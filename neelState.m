function varargout = neelState(varargin)
%NEELSTATE Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.neelState instead.

qfiDeprecatedRootApi('neelState', 'QFIEntanglementToolbox.neelState');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.neelState(varargin{:});
else
    QFIEntanglementToolbox.neelState(varargin{:});
end
end
