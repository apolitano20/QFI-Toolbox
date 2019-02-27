function X = mkron(varargin)
% MKRON  This is how kron should work, dammit.
%  X = mkron(A, B, ...)
%
%  Returns the tensor (Kronecker) product X = A \otimes B \otimes ...

% Ville Bergholm 2009


X = 1;
for k = 1:nargin
  X = kron(X, varargin{k});
end