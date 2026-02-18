function varargout = phaseShiftGenerator(varargin)
%PHASESHIFTGENERATOR Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.qfi.phaseShiftGenerator.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.qfi.phaseShiftGenerator(varargin{:});
else
    QFIEntanglementToolbox.qfi.phaseShiftGenerator(varargin{:});
end
end
