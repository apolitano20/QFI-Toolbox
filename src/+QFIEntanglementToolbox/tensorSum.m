function varargout = tensorSum(varargin)
%TENSORSUM Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.linalg.tensorSum.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.linalg.tensorSum(varargin{:});
else
    QFIEntanglementToolbox.linalg.tensorSum(varargin{:});
end
end
