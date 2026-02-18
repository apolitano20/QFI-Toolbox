function varargout = bipartiteEntanglement(varargin)
%BIPARTITEENTANGLEMENT Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.entanglement.bipartiteEntanglement.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.entanglement.bipartiteEntanglement(varargin{:});
else
    QFIEntanglementToolbox.entanglement.bipartiteEntanglement(varargin{:});
end
end
