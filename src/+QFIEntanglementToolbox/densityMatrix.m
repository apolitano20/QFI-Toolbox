function rho = densityMatrix(hamiltonian,temperature)
%%  DENSITYMATRIX Returns the density matrix \rho = exp(-\beta H)
%   This function has two required input arguments:
%     hamiltonian: the input Hamiltonian
%     temperature: the temperature 
%   
%   rho = densityMatrix(hamiltonian,temperature) returns the density matrix \rho = exp(-\beta H)
%   for a givem Hamoltonian H and a temperature T. \beta = 1/T.
%
%   WARNING: This function involves the exponentiation of a sparse matrix
%   mutiplied for an inverse temperature T. Given the fast growth of the
%   term beta = 1/T computational errors may appear for  excessively small
%   values of T.
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
%
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

if temperature < 0.005
    error('T is too small. Set a larger value for the temperature')
else
expHamiltonian = expm(-hamiltonian/temperature);
partitionFunc = trace(expHamiltonian);
rho = expHamiltonian/partitionFunc;
end
end
