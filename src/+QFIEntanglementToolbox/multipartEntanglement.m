function varargout = multipartEntanglement(varargin)
%MULTIPARTENTANGLEMENT Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.entanglement.multipartEntanglement.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.entanglement.multipartEntanglement(varargin{:});
else
    QFIEntanglementToolbox.entanglement.multipartEntanglement(varargin{:});
end
end
