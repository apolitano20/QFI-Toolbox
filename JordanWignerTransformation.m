function varargout = JordanWignerTransformation(varargin)
%JORDANWIGNERTRANSFORMATION Backward-compatible wrapper for migrated package API.
%   Deprecated: use QFIEntanglementToolbox.JordanWignerTransformation instead.

qfiDeprecatedRootApi('JordanWignerTransformation', 'QFIEntanglementToolbox.JordanWignerTransformation');
if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.JordanWignerTransformation(varargin{:});
else
    QFIEntanglementToolbox.JordanWignerTransformation(varargin{:});
end
end
