function distanceVal = traceDistance(statePsi,statePhi)
%%  TRACEDISTANCE Computes the the trace distance between the two input states |statePsi> and |statePhi>
%	This function has two required input argument:
%	statePsi: the first input quantum state (vector or density matrix)
%   statePhi: the second input quantum state (vector or density matrix)
%
%   distanceVal = traceDistance(statePsi,statePhi) returns the trace distance
%   between statePsi and statePhi. If inputs are state vectors, they are
%   converted to density matrices: \rho = |statePsi><statePsi| and \sigma = |statePhi><statePhi|.
%   The function then computes T(\rho,\sigma) = 1/2 Tr[sqrt((rho - sigma)^2)].
%   Being rho and sigma hermitian the above mentioned quantity can be
%   written as T(\rho,\sigma) = 1/2\sum_k |\lambda_k|, where \lambda_k are
%   the eigenvalues of \delta = (\rho - \sigma). This is equivalent to
%   1/2 * sum of singular values of (rho - sigma).
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: QFIEntanglementToolbox.pureToMixed (implicitly, or handle internally)
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

% Ensure inputs are density matrices
rho = QFIEntanglementToolbox.states.pureToMixed(statePsi);
sigma = QFIEntanglementToolbox.states.pureToMixed(statePhi);

deltaRhoSigma = rho - sigma;
singularValues = svd(deltaRhoSigma); 
singularValues(singularValues < 1e-12) = 0;
distanceVal = 1/2*sum(singularValues);
end

