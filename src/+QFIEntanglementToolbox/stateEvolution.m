function evolvedStates = stateEvolution(hamiltonian,initialState,numSteps)
%%  STATEEVOLUTION returns the time evolution of the input state under the input Hamiltonian
%	This function has three required input argument:
%	hamiltonian: The Hamiltonian acting on the input state
%   initialState: the quantum state to be evolved
%   numSteps: the number of steps
%
%   evolvedStates = stateEvolution(hamiltonian,initialState,numSteps) returns the time evolved state initialState
%   under the action of the input Hamiltonian H.
%     
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

dt = 0.05; % Time step
uDt = expm(-sqrt(-1)*hamiltonian*dt); %time evolution operator for one dt
evolvedStates = zeros(length(initialState),numSteps);
evolvedStates(:,1) = initialState;
currentStateVec = initialState;
for iStep = 2:numSteps
    currentStateVec = uDt*currentStateVec;
    evolvedStates(:,iStep) = currentStateVec;
end
end
