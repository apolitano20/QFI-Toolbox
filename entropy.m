function S = entropy(state)
%%  ENTROPY    Computes the von Neumann entropy of a density matrix
%   This function has one required argument:
%     state: a density matrix
%
%   ENT = Entropy(RHO) is the (base 2) von Neumann entropy of RHO.
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
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

lambda = eig(rho,'vector');
lambda = cleanMat(lambda,10e-5);
lambda = nonzeros(lambda);
S = -sum(lambda.*log2(lambda));
S = cleanMat(S,10e-8);
end