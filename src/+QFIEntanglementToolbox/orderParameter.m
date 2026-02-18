function varargout = orderParameter(varargin)
%ORDERPARAMETER Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.entanglement.orderParameter.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.entanglement.orderParameter(varargin{:});
else
    QFIEntanglementToolbox.entanglement.orderParameter(varargin{:});
end
end
