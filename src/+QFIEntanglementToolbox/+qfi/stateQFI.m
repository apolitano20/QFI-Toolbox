function [maxQFI, varianceQFI, maxIndex] = stateQFI(inputState,numBlochVec,distributionType)
%% STATEQFI returns the estimate QFI for the input state |inputState>
%
%	This function has three required input arguments:
%	inputState: the input state (can be a single vector or a matrix where each column is a state)
%	numBlochVec: number of generated operators
%   distributionType: probability distribution function for the orientation of the
%   Bloch vectors
%
%   [maxQFI, varianceQFI, maxIndex] = stateQFI(inputState,numBlochVec,distributionType) the estimated
%   quantim Fisher information for the input state |inputState>. The function
%   starts by generating an ensemble of linear phase shift generators 
%   J = 1/2 \sum_{k = 1}^L n_k*sigma_k. Then the variance of the input
%   state over these operator is calculated and the max of these variances
%   is taken as the estimated QFI for |inputState>.
%   The Bloch vectors in n_l are randomly generated from the distribution
%   "distributionType".
%   distributionType accepts five options: 1. uniform: the Bloch vectors are uniformly
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
 
%	requires: QFIEntanglementToolbox.phaseShiftEnsemble, QFIEntanglementToolbox.utils.progressBar
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%  BULDING BLOCKS and MEMORY ALLOCATION
    [dimState, numStates] = size(inputState);
    chainLength = log2(dimState);
    qfiValues = zeros(numStates,numBlochVec);
%%  PHASE SHIFT OPERATORS 
	[jEnsemble, ~] = QFIEntanglementToolbox.qfi.phaseShiftEnsemble(chainLength,numBlochVec,distributionType);
	QFIEntanglementToolbox.utils.progressBar('BlochVector')
	for iBloch = 1:numBlochVec
        jOp = jEnsemble{iBloch};
        jOpSq = jOp^2;
        
        term1_sum_elements = zeros(numStates,1);
        term2_sum_elements_sq = zeros(numStates,1);

        for iState = 1:numStates
            currentState = inputState(:,iState);
            term1_sum_elements(iState) = currentState' * jOpSq * currentState;
            term2_sum_elements_sq(iState) = (currentState' * jOp * currentState)^2;
        end
        
        qfiValues(:,iBloch) = 4 * (term1_sum_elements - term2_sum_elements_sq);
        QFIEntanglementToolbox.utils.progressBar(iBloch/numBlochVec)
	end
	qfiValues = real(qfiValues);
	[maxQFI, maxIndex] = max(qfiValues,[],2);
	varianceQFI = var(qfiValues,0,2);
end

