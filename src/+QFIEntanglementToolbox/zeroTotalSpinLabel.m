function varargout = zeroTotalSpinLabel(varargin)
%ZEROTOTALSPINLABEL Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.states.zeroTotalSpinLabel.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.states.zeroTotalSpinLabel(varargin{:});
else
    QFIEntanglementToolbox.states.zeroTotalSpinLabel(varargin{:});
end
end
