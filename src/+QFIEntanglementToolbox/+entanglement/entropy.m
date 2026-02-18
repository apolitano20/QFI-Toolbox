function entropyVal = entropy(inputState)
%%  ENTROPY    Computes the von Neumann entropy of a density matrix
%   This function has one required argument:
%     inputState: a density matrix or a pure state vector
%
%   entropyVal = entropy(inputState) is the (base 2) von Neumann entropy of inputState.
%   If inputState is a pure state vector, it is first converted to a density matrix.
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: QFIEntanglementToolbox.utils.cleanMat
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

if  ~ismatrix(inputState)
    error('The input state should be a column vector or a square matrix')
end

if isvector(inputState) && size(inputState,2) ~= 1 % Ensure it's a column vector if it's a vector
    inputState = inputState';
end

densityMat = inputState; % Default assignment
if isvector(inputState)
    cleanState = QFIEntanglementToolbox.utils.cleanMat(inputState,10e-5);
    densityMat = cleanState*cleanState';
end

eigenvalues = eig(densityMat,'vector');
eigenvalues = QFIEntanglementToolbox.utils.cleanMat(eigenvalues,10e-5);
eigenvalues = nonzeros(eigenvalues); % Remove zero eigenvalues to avoid log(0)
if isempty(eigenvalues) % Handle case of zero matrix or all eigenvalues cleaned to zero
    entropyVal = 0;
else
    entropyVal = -sum(eigenvalues.*log2(eigenvalues));
end
entropyVal = QFIEntanglementToolbox.utils.cleanMat(entropyVal,10e-8); % Clean final result
end

