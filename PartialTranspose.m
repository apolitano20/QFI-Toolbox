function varargout = PartialTranspose(varargin)
%PARTIALTRANSPOSE Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.PartialTranspose instead.

qfiDeprecatedRootApi('PartialTranspose', 'QFIEntanglementToolbox.PartialTranspose');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.PartialTranspose(varargin{:});
else
    QFIEntanglementToolbox.PartialTranspose(varargin{:});
end
end
