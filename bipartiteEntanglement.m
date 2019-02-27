function S = bipartiteEntanglement(state,k)
%%  BIPARTITEENTANGLEMENT  Computes the entanglement entropy of a quantum state
%   This function has one required input argument:
%     rho: the input quantum state 
%
%   S = bipartiteEntanglement(state) returns the bipartite entanglement
%   entropy entropy of quantum state with respect to a bipartition of the
%   state into two partitions A and B of the same lenght. If the input
%   state is a density matrix rho_{AB}, the entropy of entanglement is
%   given by S = -trace(rho_A log rho_A), where rho_A is the rediced
%   density matrix for the partition A (the subsystem B is traced out).
%
%   This function has one optional input argument valid for discrete
%   systems (e.g. spin systems):
%     
%   k (default L/2): lenght of the subsystem A. 
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: PartialTrace (from the QETLAB package)
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

if  ~ismatrix(state)
    error('The input state should be a column vector or a square matrix')
end

if isvector(state) && size(state,2) ~= 1
    state = state';
end

L = log2(size(state,1));
if nargin == 1
    k = L/2;
end

if k > L
    error('The size of a subsystem should be less than L = %d', L)
end

if isvector(state)
    state = cleanMat(state,10e-5);
    rho = state*state';
end

partition = [2^k,2^(L-k)];
rhoA = PartialTrace(rho,2,partition);
lambda = eig(rhoA,'vector');
lambda = cleanMat(lambda,10e-5);
lambda = nonzeros(lambda);
S = -sum(lambda.*log2(lambda));
end