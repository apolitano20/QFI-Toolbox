function varargout = boundQFI(varargin)
%BOUNDQFI Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.boundQFI instead.

qfiDeprecatedRootApi('boundQFI', 'QFIEntanglementToolbox.boundQFI');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.boundQFI(varargin{:});
else
    QFIEntanglementToolbox.boundQFI(varargin{:});
end
end
