function varargout = JordanWignerTransformation(varargin)
%JORDANWIGNERTRANSFORMATION Public facade that preserves the package API.
%   Implementation lives in QFIEntanglementToolbox.hamiltonians.JordanWignerTransformation.

if nargout > 0
    [varargout{1:nargout}] = QFIEntanglementToolbox.hamiltonians.JordanWignerTransformation(varargin{:});
else
    QFIEntanglementToolbox.hamiltonians.JordanWignerTransformation(varargin{:});
end
end
