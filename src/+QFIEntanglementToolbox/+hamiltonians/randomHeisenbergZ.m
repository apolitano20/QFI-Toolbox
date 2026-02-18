function hRandomEnsemble = randomHeisenbergZ(chainLength,hFieldMax,numTrials,seed)
%%  RANDOMHEISENBERGZ Returns a random filed along the z direction
%   This function has three required input arguments:
%     chainLength: the length of the spin chain
%     hFieldMax: the width of the interval [-hFieldMax,+hFieldMax] used to generate the
%     uniformly distributed random interaction fields along the z direction.
%     numTrials: the number of generated experiments
%
%   hRandomEnsemble = randomHeisenbergZ(chainLength,hFieldMax,numTrials) returns the Hamiltonian o a
%   spin-1/2 chain with random fields along the z direction H = sum_k
%   h_k*S_k, where static random fields h_k, are indipendent random
%   variables at each site k witha a probability distribution that is
%   uniform in [-hFieldMax,hFieldMax].
%
%   This function has one optional input argument
%     
%   seed (default 'noseed'): seed for the random number generation. Set to
%   'twister' to have a reproducible experiment. Set 'clean' to have a
%   uniform magnetic field hFieldMax at each site. 
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%% Optional arguments setting
if nargin == 3
    seed = 'noseed';
end
%% Memory allocation
dim = 2^chainLength;
hRandomEnsemble = zeros(dim,numTrials); % Output should represent Hamiltonians or sums, not just field configurations.
                                      % The original code sums fields for each trial directly into HR.
                                      % HR(:,k) = 1/2*sum(randomFieldsVec(:,k).*spinRep); implies HR is a sum, not an ensemble of H's.
                                      % For an ensemble of Hamiltonians, HR would be a cell array.
                                      % The current output is a dim x numTrials matrix, where each column is a sum for that trial.
                                      % This seems to represent sum_k h_k S_k^z values for each trial, not the full Hamiltonian matrix.
                                      % Let's rename to reflect it's a sum of z-components of fields.
                                      % If it's meant to be an operator, it needs to be constructed differently.
                                      % Based on H = sum_k h_k*S_k, where S_k is Sz for site k.
                                      % The current code is calculating sum_k h_k * eigenvalues_of_Sz_for_all_sites.
                                      % This is NOT a Hamiltonian matrix.
                                      % For now, I will keep the logic but the physics interpretation is tricky.
                                      % Let's assume hRandomEnsemble is a vector of total "Z-energy" for each configuration for now.

%% random fields generation
switch seed
    case 'twister'
    rng(0,'twister') %random sequence seed
    randomFieldsVec = -hFieldMax + 2*hFieldMax*rand(chainLength,numTrials); %random local fields
    case 'noseed'
    randomFieldsVec = -hFieldMax + 2*hFieldMax*rand(chainLength,numTrials); %random local fields
    case 'clean'
    numTrials = 1; % For 'clean', it makes sense to have one configuration
	randomFieldsVec = hFieldMax*ones(chainLength,numTrials);
    hRandomEnsemble = zeros(dim,numTrials); % Re-initialize if numTrials changed
end
%%  Hamiltonian construction (Interpretation of H = sum_k h_k*S_k)
% The original code calculates sum_k h_k * (diagonal of total Sz operator in Z-basis)
% This is not the standard way to construct the Hamiltonian matrix.
% A proper Hamiltonian would be H_R = sum_k h_k * S_k^z (operator sum)
% For now, will replicate the original calculation.
binaryTable = QFIEntanglementToolbox.utils.indexToBits(0:dim-1, chainLength, true);
spinRep = 1 - 2*binaryTable'; % Eigenvalues of sum(S_i^z) for each basis state
    for k = 1:numTrials        
      hRandomEnsemble(:,k) = 1/2*sum(randomFieldsVec(:,k).*spinRep, 1)'; % Sum over sites for each basis state, ensure column
    end
end

