function NEEL_STATE = neelState(L)
%%	NEELSTATE Generates a N�el state
%	This function one required input arguments:
%	L: the length of the spin chain
%
%   NEEL_STATE = neelState(L) returns the N�el state. 
%   For a system of L qubits the N�el state can be
%   written as |N�el> = (|01>^{\otimes L/2} + |10>^{\otimes L/2})/sqrt(2).
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
%
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

%%  Single qubits
	u = [1;0];
    d = [0;1];
%%  Building block
    NS = kron(u,d);
    neelStateTemp = NS;
%% N�el state construction
    for iLoop = 1:L/2-1
        neelStateTemp = kron(neelStateTemp,NS);
    end
    NEEL_STATE = 1/sqrt(2)*(neelStateTemp + flipud(neelStateTemp));
end