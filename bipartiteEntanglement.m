function varargout = bipartiteEntanglement(varargin)
%BIPARTITEENTANGLEMENT Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.bipartiteEntanglement instead.

qfiDeprecatedRootApi('bipartiteEntanglement', 'QFIEntanglementToolbox.bipartiteEntanglement');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.bipartiteEntanglement(varargin{:});
else
    QFIEntanglementToolbox.bipartiteEntanglement(varargin{:});
end
end
