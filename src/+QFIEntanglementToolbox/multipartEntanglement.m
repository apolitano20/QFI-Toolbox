function mpeValues = multipartEntanglement(qfiValues,chainLength)
%%  MULTIPARTENTANGLEMENT returns the amount of MPE given the amount of QFI
%	This function has two required input arguments:
%	chainLength: lenght of the spin chain
%   qfiValues: vector or quantum Fisher information values
%   
%   mpeValues = multipartEntanglement(qfiValues,chainLength) returns the amount of multipartite
%   entanglement given the ampunt of quantum Fisher information and the
%   spin chain length chainLength. Quantum Fisher information (QFI) and multipartite
%   entanglement (MPE) are relate by the bound F_Q \leq sk^2 + (L - sk)^2,
%   where s = floor(L/k). If the bound is violated, then the probe state
%   \rho contains useful (k+1)-partite. 
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: QFIEntanglementToolbox.boundQFI
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

entanglementBounds = QFIEntanglementToolbox.boundQFI(chainLength);
mpeValues = qfiValues;
mpeValues(mpeValues <= chainLength) = 0; 
mpeValues(qfiValues == chainLength^2) = chainLength-1;
for kValue = 2:chainLength
mpeValues(qfiValues > entanglementBounds(kValue-1) & qfiValues < entanglementBounds(kValue)) = kValue-1;
end
mpeValues = mpeValues + 1;
end
