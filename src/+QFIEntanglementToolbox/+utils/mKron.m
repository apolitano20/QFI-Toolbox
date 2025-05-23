function x = mKron(varargin)
% MKRON  This is how kron should work, dammit.
%  x = mKron(A, B, ...)
%
%  Returns the tensor (Kronecker) product x = A \otimes B \otimes ...
%
% package: QFIEntanglementToolbox.utils

% Ville Bergholm 2009

x = 1;
for k = 1:nargin
  x = kron(x, varargin{k});
end
