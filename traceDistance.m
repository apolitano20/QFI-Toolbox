function stateDistance = traceDistance(psi,phi)
%%  TRACEDISTANCE Computes the the trace distance between the two input states |psi> and |phi>
%	This function has two required input argument:
%	psi: the first input quantum state 
%   phi: the second input quantum state 
%
%   stateDistance = traceDistance(psi,phi) returns the trace distance
%   between |phi> and |psi>. It writes the two input states in the density
%   matrix formalism: \rho = |psi><psi| and \sigma = |phi><phi| and
%   computes the quantity T(\rho,\sigma) = 1/2 Tr[sqrt((rho - sigma)^2)].
%   Being rho and sigma hermitian the above mentioned quantity can be
%   written as T(\rho,\sigma) = 1/2\sum_k |\lambda_k|, where \lambda_k are
%   the eigenvalues of \delta = (\rho - \sigma).
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 27, 2019

if isrow(psi) == 1
    psi = psi';
end
if isrow(phi) == 1
    phi = phi';
end

delta = psi*psi' - phi*phi';
schmidtCoeff = svd(delta);
schmidtCoeff(abs(schmidtCoeff) < 10e-4) = [];
stateDistance = 1/2*sum(schmidtCoeff);
end