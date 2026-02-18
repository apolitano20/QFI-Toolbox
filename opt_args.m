function varargout = opt_args(varargin)
%OPT_ARGS Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.utils.optArgs instead.

qfiDeprecatedRootApi('opt_args', 'QFIEntanglementToolbox.utils.optArgs');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.utils.optArgs(varargin{:});
else
    QFIEntanglementToolbox.utils.optArgs(varargin{:});
end
end
