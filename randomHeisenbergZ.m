function varargout = randomHeisenbergZ(varargin)
%RANDOMHEISENBERGZ Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.randomHeisenbergZ instead.

qfiDeprecatedRootApi('randomHeisenbergZ', 'QFIEntanglementToolbox.randomHeisenbergZ');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.randomHeisenbergZ(varargin{:});
else
    QFIEntanglementToolbox.randomHeisenbergZ(varargin{:});
end
end
