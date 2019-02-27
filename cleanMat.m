function outM = cleanMat(M,eps)
%%  CLEANMAT sets a treshoold accuracy for an input marix V
%   This function has two required input argument:
%     M: the input matrix/vector M
%     eps: the threshold 
%
%   outM = cleanMat(M,eps) returns a the input matrix M where all entries
%   whose value is smaller than eps are set to zero and entries whose
%   relative difference is smaller then epsilon are se to the same value.
%
%   WARNING: This function is not optimized and may require long
%   computation times for excessively large matrices.
%
% >>outM = cleanMat([0.2, 0.3, 1.5, 1.7],0.5)
% >>outM = [0, 0, 1.5, 1.5]
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

[nRow, nCol] = size(M);
M(abs(M) < eps) = 0;
for iCol = 1:nCol
    for iRow = 1:nRow
        for jRow = 1:nRow
            if abs(M(iRow,iCol) - M(jRow,iCol)) < eps
                M(jRow,iCol) = M(iRow,iCol);
            end
        end
    end
end
outM = M;
end