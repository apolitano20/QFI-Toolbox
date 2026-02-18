function varargout = multipartEntanglement(varargin)
%MULTIPARTENTANGLEMENT Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.multipartEntanglement instead.

qfiDeprecatedRootApi('multipartEntanglement', 'QFIEntanglementToolbox.multipartEntanglement');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.multipartEntanglement(varargin{:});
else
    QFIEntanglementToolbox.multipartEntanglement(varargin{:});
end
end
