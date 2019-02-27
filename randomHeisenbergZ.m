function HR = randomHeisenbergZ(L,h,trials,seed)
%%  RANDOMHEISENBERGZ Returns a random filed along the z direction
%   This function has three required input arguments:
%     L: the length of the spin chain
%     h: the width of the interval [-h,+h] used to generate the
%     uniformly distributed random interaction fields along the z direction.
%     trials: the number of generated experiments
%
%   H = randomHeisenbergZ(L,delta,trials) returns the Hamiltonian o a
%   spin-1/2 chain with random fields along the z direction H = sum_k
%   h_k*S_k, where static random fields h_k, are indipendent random
%   variables at each site k witha a probability distribution that is
%   uniform in [-h,h].
%
%   This function has one optional input argument
%     
%   seed (default 'noseed'): seed for the random number generation. Set to
%   'twister' to have a reproducible experiment. Set 'clean' to have a
%   uniform magnetic field h at each site. 
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

%% Optional arguments setting
if nargin == 3
    seed = 'noseed';
end
%% Memory allocation
dim = 2^L;
HR = zeros(dim,trials);
%% random fields generation
switch seed
    case 'twister'
    rng(0,'twister') %random sequence seed
    randomFields = -h + 2*h*rand(L,trials); %random local fields
    case 'noseed'
    randomFields = -h + 2*h*rand(L,trials); %random local fields
    case 'clean'
    trials = 1;
	randomFields = h*ones(L,trials);
end
%%  Hamiltonian construction
spin_rep = 1 - 2*de2bi(0:dim-1,L,'left-msb')';
    for k = 1:trials        
      HR(:,k) = 1/2*sum(randomFields(:,k).*spin_rep);
    end
end