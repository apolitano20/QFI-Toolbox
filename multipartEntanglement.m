function mpe = multipartEntanglement(v,L)
%%  MULTIPARTENTANGLEMENT returns the amount of MPE given the amount of QFI
%	This function has two required input arguments:
%	L: lenght of the spin chain
%   v: vector or quantum Fisher information values
%   
%   mpe = multipartEntanglement(v,L) returns the amount of multipartite
%   entanglement given the ampunt of quantum Fisher information and the
%   spin chain length L. Quantum Fisher information (QFI) and multipartite
%   entanglement (MPE) are relate by the bound F_Q \leq sk^2 + (L - sk)^2,
%   where s = floor(L/k). If the bound is violated, then the probe state
%   \rho contains useful (k+1)-partite. 
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: boundQFI
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

bound = boundQFI(L);
mpe = v;
mpe(mpe < L) = 0; 
mpe(v == L^2) = L;
for ik = 2:L
mpe(v > bound(ik-1) & v < bound(ik)) = ik-1;
end
mpe = mpe + 1;
end