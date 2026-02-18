function varargout = randpdf(varargin)
%RANDPDF Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.randPdf instead.

qfiDeprecatedRootApi('randpdf', 'QFIEntanglementToolbox.utils.randPdf');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.randPdf(varargin{:});
else
    QFIEntanglementToolbox.utils.randPdf(varargin{:});
end
end
