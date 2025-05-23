function bounds = boundQFI(chainLength)
%% BOUNDQFI computes the the bound values for the multipartite entanglement
%           
%   This function has one required input argument:
%	chainLength: lenght of the spin chain.
%
%   bounds = boundQFI(chainLength) returns the bounds for the quantum Fisher information
%   whose violation signals the presence of multipartite entanglement.
%   If the bound F_Q \leq sk^2 + (L - sk)^2, where s = floor(L/k) is
%   violated, then the probe state \rho_{k} contains useful (k+1)-partite
%   entanglement. 
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox


kVec = 1:chainLength;
bounds = floor(chainLength./kVec).*(kVec.^2) + (chainLength - floor(chainLength./kVec).*kVec).^2;
end
