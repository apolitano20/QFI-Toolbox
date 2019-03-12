function rho = densityMatrix(H,T)
%%  DENSITYMATRIX Returns the density matrix \rho = exp(-\beta H)
%   This function has two required input arguments:
%     H: the input Hamiltonian
%     T: the temperature 
%   
%   H = densityMatrix(H,T) returns the density matrix \rho = exp(-\beta H)
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
%	package: QFI Toolbox 
%	last updated: February 26, 2019

if T < 0.005
    erro('T is too small. Set a larger value for the temperature')
else
expH = expm(-H/T);
Z = trace(expH);
rho = expH/Z;
end
end
