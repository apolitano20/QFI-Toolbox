function varargout = heisenbergXXZ(varargin)
%HEISENBERGXXZ Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.heisenbergXXZ instead.

qfiDeprecatedRootApi('heisenbergXXZ', 'QFIEntanglementToolbox.heisenbergXXZ');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.heisenbergXXZ(varargin{:});
else
    QFIEntanglementToolbox.heisenbergXXZ(varargin{:});
end
end
