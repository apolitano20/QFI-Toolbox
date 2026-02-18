function varargout = PartialTrace(varargin)
%PARTIALTRACE Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.linalg.PartialTrace.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.linalg.PartialTrace(varargin{:});
else
    QFIEntanglementToolbox.linalg.PartialTrace(varargin{:});
end
end
