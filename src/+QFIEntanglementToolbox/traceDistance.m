function varargout = traceDistance(varargin)
%TRACEDISTANCE Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.linalg.traceDistance.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.linalg.traceDistance(varargin{:});
else
    QFIEntanglementToolbox.linalg.traceDistance(varargin{:});
end
end
