function varargout = phaseShiftGenerator(varargin)
%PHASESHIFTGENERATOR Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.phaseShiftGenerator instead.

qfiDeprecatedRootApi('phaseShiftGenerator', 'QFIEntanglementToolbox.phaseShiftGenerator');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.phaseShiftGenerator(varargin{:});
else
    QFIEntanglementToolbox.phaseShiftGenerator(varargin{:});
end
end
