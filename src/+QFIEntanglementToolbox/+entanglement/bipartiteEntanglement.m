function entanglementEntropy = bipartiteEntanglement(inputState,subsystemSize)
%%  BIPARTITEENTANGLEMENT  Computes the entanglement entropy of a quantum state
%   This function has one required input argument:
%     inputState: the input quantum state 
%
%   entanglementEntropy = bipartiteEntanglement(inputState) returns the bipartite entanglement
%   entropy entropy of quantum state with respect to a bipartition of the
%   state into two partitions A and B of the same lenght. If the input
%   state is a density matrix rho_{AB}, the entropy of entanglement is
%   given by S = -trace(rho_A log rho_A), where rho_A is the rediced
%   density matrix for the partition A (the subsystem B is traced out).
%
%   This function has one optional input argument valid for discrete
%   systems (e.g. spin systems):
%     
%   subsystemSize (default L/2): lenght of the subsystem A. 
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: QFIEntanglementToolbox.PartialTrace, QFIEntanglementToolbox.utils.cleanMat
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

if  ~ismatrix(inputState)
    error('The input state should be a column vector or a square matrix')
end

if isvector(inputState) && size(inputState,2) ~= 1
    inputState = inputState';
end

totalQubits = log2(size(inputState,1));
if nargin == 1
    subsystemSize = totalQubits/2;
end

if subsystemSize > totalQubits
    error('The size of a subsystem should be less than L = %d', totalQubits)
end

densityMat = inputState; % Initialize densityMat with inputState
if isvector(inputState)
    inputState = QFIEntanglementToolbox.utils.cleanMat(inputState,10e-5);
    densityMat = inputState*inputState';
end

partitionDims = [2^subsystemSize,2^(totalQubits-subsystemSize)];
rhoSubsystemA = QFIEntanglementToolbox.linalg.PartialTrace(densityMat,2,partitionDims);
eigenvalues = eig(rhoSubsystemA,'vector');
eigenvalues = QFIEntanglementToolbox.utils.cleanMat(eigenvalues,10e-5);
eigenvalues = nonzeros(eigenvalues);
entanglementEntropy = -sum(eigenvalues.*log2(eigenvalues));
end

