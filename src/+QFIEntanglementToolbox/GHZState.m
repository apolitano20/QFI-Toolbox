function ghzState = GHZState(numQubits)
%%	GHZSTATE	Generates a GreenbergerHorneZeilinger (GHZ) state
%	This function one required input arguments:
%     numQubits: the space dimention
%
%   ghzState = GHZState(numQubits) returns the GHZ 
%   For a system of L qubits the GHZ state can be
%   written as |GHZ> = (|0>^{\otimes Q} + |1>^{\otimes Q})/sqrt(2).
%
%	References:
%   [1] Going beyond Bell's theorem. D. Greenberger and M. Horne and A. 
%       Zeilinger. E-print: [quant-ph] arXiv:0712.0921. 2007.
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
%
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

dim = 2^numQubits;
tmpVec = zeros(dim,1);
tmpVec([1,end]) = 1;
ghzState = 1/sqrt(2)*tmpVec;
end
