function varargout = progressbar(varargin)
%PROGRESSBAR Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.progressBar instead.

qfiDeprecatedRootApi('progressbar', 'QFIEntanglementToolbox.utils.progressBar');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.progressBar(varargin{:});
else
    QFIEntanglementToolbox.utils.progressBar(varargin{:});
end
end
