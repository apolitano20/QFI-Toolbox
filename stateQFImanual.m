function [maxF, varF, idx, F] = stateQFImanual(state,elevation,azimuth)
%% PHASESHIFTENSEMBLE returns the  QFI for the input state |state> and a given phase shift generator
%
%	This function has three required input arguments:
%	state: the input state
%	nBlochVec: number of generated operators
%	elevation: L x 1 vector whose l-th entry is the elevation of the
%   Bloch vector on the l-th site.
%   azimuth: L x 1 vector, as above.
%
%   [maxF, varF, idx] = stateQFI(state,nBlochVec,distr) the estimated
%   quantim Fisher information for the input state |state>. The function
%   generates a linear phase shift generator J = 1/2 \sum_{k = 1}^L n_k*sigma_k.
%   n_l = (\alpha_l, \beta_l, gamma_l), l = {1,...,L} is a vector on the
%   Bloch sphere. The inputs "elevation" and "azimuth" are Lx1 vectors
%   containing the elevation and azimuth coordinates for each of the L
%   (\alpha_l, \beta_l and \gamma_l).
%   
%   Example:
%   >> elevation = 0*ones(8,1);
%   >> azimuth =  pi/2*ones(8,1);
%   >> state = GHZState(4); % |GHZ> = 1/sqrt(2)(|0000> + |1111>)
%   >> F = stateQFImanual(state,elevation,azimuth)
%   >> 16
%
%   The example above returns the Fisher information for the quantum state
%   |GHZ> (whic is a L-partite entangled state) and a phase shift generator
%   constructed through the Bloch vector n_l with the given elevation and
%   azimuth. In this specific example all local directions n_l are the same
%   and they point at the north pole of the sphere. For this configuration
%   the Fisher information is the maximum achievable, thus it corresponds
%   to the quantum Fisher information
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)
%   [2] S.L. Braunstein and C.M. Caves, Phys.Rev.Lett. 72,3439 (1994)

%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: phaseShiftGenerator.m
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 27, 2019

%%  BUILDING BLOCKS and MEMORY ALLOCATION
    [dim, nState] = size(state);
    L = log2(dim);
    nBlochVec = length(elevation)/L;
    F = zeros(nState,nBlochVec);
%%  PHASE SHIFT GENERATOR
    J = phaseShiftGenerator(L,elevation,azimuth);
%%  FISHER INFORMATION     
	for iBlochVec = 1:nBlochVec
        F(:,iBlochVec) = 4*(sum(conj(state).*(J{iBlochVec}^2*state)) ...
	- sum((conj(state).*(J{iBlochVec}*state))).^2);
	end
	F = real(F);
	[maxF, idx] = max(F,[],2);
	varF = var(F,0,2);
end