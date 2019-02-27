function [maxF, varF, idx] = stateQFI(state,nBlochVec,distr)
%% PHASESHIFTENSEMBLE returns the estimate QFI for the input state |state>
%
%	This function has three required input arguments:
%	state: the input state
%	nBlochVec: number of generated operators
%   distr: probability distribution function for the orientation of the
%   Bloch vectors
%
%   [maxF, varF, idx] = stateQFI(state,nBlochVec,distr) the estimated
%   quantim Fisher information for the input state |state>. The function
%   starts by generating an ensemble of linear phase shift generators 
%   J = 1/2 \sum_{k = 1}^L n_k*sigma_k. Then the variance of the input
%   state over these operator is calculated and the max of these variances
%   is taken as the estimated QFI for |state>.
%   The Bloch vectors in n_l are randomly generated from the distribution
%   "distr".
%   distr accepts five options: 1. uniform: the Bloch vectors are uniformly
%   distributed over the Bloch sphere. 2. XY: concentrated at the equator
%   of the Bloch sphere. 3. polar: concentrated at the poles. 4.
%   equatorial: concentated around the pole. 5. homogeneous: randomly
%   distributed over the bloch sphere but al the vectors in n_l have the
%   same orientation.
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)
%   [2] S.L. Braunstein and C.M. Caves, Phys.Rev.Lett. 72,3439 (1994)
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: phaseShiftEnsemble.m, progressbar.m
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 27, 2019

%%  BULDING BLOCKS and MEMORY ALLOCATION
    [dim, nState] = size(state);
    L = log2(dim);
    F = zeros(nState,nBlochVec);
%%  PHASE SHIFT OPERATORS 
	[J, ~] = phaseShiftEnsemble(L,nBlochVec,distr);
	progressbar('BlochVector')
	for iBlochVec = 1:nBlochVec
        F(:,iBlochVec) = 4*(sum(conj(state).*(J{iBlochVec}^2*state))...
            - sum((conj(state).*(J{iBlochVec}*state))).^2);
        progressbar(iBlochVec/nBlochVec)
	end
	F = real(F);
	[maxF, idx] = max(F,[],2);
	varF = var(F,0,2);
end