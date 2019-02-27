function [maxF, varF] = rhoQFI(rho,nBlochVec,distr)
%%  RHOQFI  Estimates the quantum Fisher information of a density matrix \rho
%   This function has three required input arguments:
%	rho: the input quantum state
%	nBlochVector: the number of generated vectors
%	distr: the probability distribution function fot the Bloch vectors
%
%
%   [maxF, varF] = rhoQFI(rho, bBlochVec, distr) returns the estimated
%   quantum Fisher information (maxF) of the input state \rho.
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: phaseShiftEnsemble.m, progressbar.m 
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 27, 2019

%%  BUILDING BLOCKS
    sz = size(rho);
    dim = sz(1);
    L = log2(dim);
    J = phaseShiftEnsemble(L,nBlochVec,distr);
%%	MEMORY ALLOCATION
    F = zeros(nBlochVec,1);
%%	QFI ESTIMATION
    [R, p] = eig(rho,'vector');
    p = flipud(p);
    P = (p - p').^2./(p + p');
	progressbar('BlochVector')
	for iBlochVec = 1:nBlochVec
        F(iBlochVec) = 2*sum(sum((P.*abs(R'*J{iBlochVec}*R).^2)));
        progressbar(iBlochVec/nBlochVec)
	end
	F = real(F);
	maxF = max(F);
	varF = var(F);
end
