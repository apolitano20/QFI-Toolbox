function varargout = PartialTranspose(varargin)
%PARTIALTRANSPOSE Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.linalg.PartialTranspose.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.linalg.PartialTranspose(varargin{:});
else
    QFIEntanglementToolbox.linalg.PartialTranspose(varargin{:});
end
end
