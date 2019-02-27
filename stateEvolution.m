function Psit = stateEvolution(H,psi0,nStep)
%%  STATEEVOLUTION returns the time evolution of the input state under the input Hamiltonian
%	This function has three required input argument:
%	H: The Hamiltonian acting on the input state
%   psi0: the quantum state to be evolved
%   nStep: the numner of steps ()
%
%   Psit = stateEvolution(H,psi0,nStep) returns the time evolved state psi0
%   under the action of the input Hamiltonian H.
%     
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 27, 2019

dt = 0.05;
Udt = expm(-sqrt(-1)*H*dt); %time evolution operator
Psit = zeros(length(psi0),nStep);
Psit(:,1) = psi0;
psit = psi0;
for iStep = 2:nStep
    psit = Udt*psit;
    Psit(:,iStep) = psit;
end
end