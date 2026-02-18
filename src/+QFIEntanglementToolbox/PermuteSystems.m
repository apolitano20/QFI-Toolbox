function varargout = PermuteSystems(varargin)
%PERMUTESYSTEMS Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.linalg.PermuteSystems.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.linalg.PermuteSystems(varargin{:});
else
    QFIEntanglementToolbox.linalg.PermuteSystems(varargin{:});
end
end
