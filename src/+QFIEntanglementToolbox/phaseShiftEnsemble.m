function varargout = phaseShiftEnsemble(varargin)
%PHASESHIFTENSEMBLE Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.qfi.phaseShiftEnsemble.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.qfi.phaseShiftEnsemble(varargin{:});
else
    QFIEntanglementToolbox.qfi.phaseShiftEnsemble(varargin{:});
end
end
