function varargout = zeroTotalSpinLabel(varargin)
%ZEROTOTALSPINLABEL Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.zeroTotalSpinLabel instead.

qfiDeprecatedRootApi('zeroTotalSpinLabel', 'QFIEntanglementToolbox.zeroTotalSpinLabel');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.zeroTotalSpinLabel(varargin{:});
else
    QFIEntanglementToolbox.zeroTotalSpinLabel(varargin{:});
end
end
