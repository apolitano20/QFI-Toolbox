function varargout = PermuteSystems(varargin)
%PERMUTESYSTEMS Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.PermuteSystems instead.

qfiDeprecatedRootApi('PermuteSystems', 'QFIEntanglementToolbox.PermuteSystems');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.PermuteSystems(varargin{:});
else
    QFIEntanglementToolbox.PermuteSystems(varargin{:});
end
end
