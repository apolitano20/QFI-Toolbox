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
hRandomEnsemble = zeros(dim,numTrials);

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
%%  Contribution along z-basis eigenstates
binaryTable = QFIEntanglementToolbox.utils.indexToBits(0:dim-1, chainLength, true);
spinRep = 1 - 2*binaryTable'; % Eigenvalues of sum(S_i^z) for each basis state
    for k = 1:numTrials        
      hRandomEnsemble(:,k) = 1/2*sum(randomFieldsVec(:,k).*spinRep, 1)'; % Sum over sites for each basis state, ensure column
    end
end

