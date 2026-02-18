function varargout = traceNorm(varargin)
%TRACENORM Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.linalg.traceNorm.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.linalg.traceNorm(varargin{:});
else
    QFIEntanglementToolbox.linalg.traceNorm(varargin{:});
end
end
