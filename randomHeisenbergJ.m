function varargout = randomHeisenbergJ(varargin)
%RANDOMHEISENBERGJ Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.randomHeisenbergJ instead.

qfiDeprecatedRootApi('randomHeisenbergJ', 'QFIEntanglementToolbox.randomHeisenbergJ');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.randomHeisenbergJ(varargin{:});
else
    QFIEntanglementToolbox.randomHeisenbergJ(varargin{:});
end
end
