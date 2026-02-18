function varargout = phaseShiftEnsemble(varargin)
%PHASESHIFTENSEMBLE Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.phaseShiftEnsemble instead.

qfiDeprecatedRootApi('phaseShiftEnsemble', 'QFIEntanglementToolbox.phaseShiftEnsemble');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.phaseShiftEnsemble(varargin{:});
else
    QFIEntanglementToolbox.phaseShiftEnsemble(varargin{:});
end
end
