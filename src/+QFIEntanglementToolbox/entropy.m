function varargout = entropy(varargin)
%ENTROPY Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.entanglement.entropy.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.entanglement.entropy(varargin{:});
else
    QFIEntanglementToolbox.entanglement.entropy(varargin{:});
end
end
