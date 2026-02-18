function varargout = rhoQFI(varargin)
%RHOQFI Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.rhoQFI instead.

qfiDeprecatedRootApi('rhoQFI', 'QFIEntanglementToolbox.rhoQFI');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.rhoQFI(varargin{:});
else
    QFIEntanglementToolbox.rhoQFI(varargin{:});
end
end
