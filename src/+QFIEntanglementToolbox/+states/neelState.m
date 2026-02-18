function neelStateOut = neelState(chainLength)
%%	NEELSTATE Generates a N??el state
%	This function one required input arguments:
%	chainLength: the length of the spin chain
%
%   neelStateOut = neelState(chainLength) returns the N??el state. 
%   For a system of L qubits the N??el state can be
%   written as |N??el> = (|01>^{\otimes L/2} + |10>^{\otimes L/2})/sqrt(2).
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
%
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%  Single qubits
	u = [1;0];
    d = [0;1];
%%  Building block
    neelBlock = kron(u,d);
    neelStateTemp = neelBlock;
%% N??el state construction
    for iLoop = 1:chainLength/2-1
        neelStateTemp = kron(neelStateTemp,neelBlock);
    end
    neelStateOut = 1/sqrt(2)*(neelStateTemp + flipud(neelStateTemp));
end

