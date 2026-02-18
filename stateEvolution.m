function varargout = stateEvolution(varargin)
%STATEEVOLUTION Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.stateEvolution instead.

qfiDeprecatedRootApi('stateEvolution', 'QFIEntanglementToolbox.stateEvolution');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.stateEvolution(varargin{:});
else
    QFIEntanglementToolbox.stateEvolution(varargin{:});
end
end
