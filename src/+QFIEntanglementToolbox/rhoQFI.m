function [maxQFI, varianceQFI] = rhoQFI(densityMatrix,numBlochVec,distributionType)
%%  RHOQFI  Estimates the quantum Fisher information of a density matrix \rho
%   This function has three required input arguments:
%	densityMatrix: the input quantum state
%	numBlochVec: the number of generated vectors
%	distributionType: the probability distribution function fot the Bloch vectors
%
%
%   [maxQFI, varianceQFI] = rhoQFI(densityMatrix, numBlochVec, distributionType) returns the estimated
%   quantum Fisher information (maxQFI) of the input state \rho.
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: QFIEntanglementToolbox.phaseShiftEnsemble, QFIEntanglementToolbox.utils.progressBar
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%  BUILDING BLOCKS
    sizeRho = size(densityMatrix);
    dimRho = sizeRho(1);
    chainLength = log2(dimRho);
    jEnsemble = QFIEntanglementToolbox.phaseShiftEnsemble(chainLength,numBlochVec,distributionType);
%%	MEMORY ALLOCATION
    qfiValues = zeros(numBlochVec,1);
%%	QFI ESTIMATION
    [eigenvectors, eigenvaluesVec] = eig(densityMatrix,'vector'); % eig returns matrix of eigenvectors and vector of eigenvalues
    eigenvaluesVec = flipud(eigenvaluesVec); % Ensure descending order if not already
    % Reconstruct eigenvectors matrix in descending order of eigenvalues
    [eigenvaluesVec, sortIdx] = sort(eigenvaluesVec,'descend');
    eigenvectors = eigenvectors(:,sortIdx);

    % Handle potential division by zero or NaN if p_i + p_j = 0
    % Create P matrix carefully
    pMatrix = zeros(dimRho, dimRho);
    for i = 1:dimRho
        for j = 1:dimRho
            sum_eig = eigenvaluesVec(i) + eigenvaluesVec(j);
            if sum_eig < eps % Avoid division by zero or very small numbers leading to NaN/Inf
                pMatrix(i,j) = 0; % Or some other appropriate handling, like skipping these terms in the sum
            else
                pMatrix(i,j) = (eigenvaluesVec(i) - eigenvaluesVec(j))^2 / sum_eig;
            end
        end
    end
    
	QFIEntanglementToolbox.utils.progressBar('BlochVector')
	for iBloch = 1:numBlochVec
        abs_matrix_element_sq = abs(eigenvectors'*jEnsemble{iBloch}*eigenvectors).^2;
        qfiValues(iBloch) = 2*sum(sum((pMatrix.*abs_matrix_element_sq)));
        QFIEntanglementToolbox.utils.progressBar(iBloch/numBlochVec)
	end
	qfiValues = real(qfiValues);
	maxQFI = max(qfiValues);
	varianceQFI = var(qfiValues);
end
