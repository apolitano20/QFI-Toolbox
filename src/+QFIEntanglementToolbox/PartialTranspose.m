%%  PARTIALTRANSPOSE    Computes the partial transpose of a matrix
%   This function has one required argument:
%     inputMat: a matrix
%
%   outputMat = PartialTranspose(inputMat) is the partial transpose of the matrix inputMat,
%   where it is assumed that the number of rows and columns of inputMat are both
%   perfect squares and both subsystems have equal dimension. The transpose
%   is applied to the second subsystem.
%
%   This function has two optional arguments:
%     sysVec (default 2)
%     dimArray (default has all subsystems of equal dimension)
%
%   outputMat = PartialTranspose(inputMat,sysVec,dimArray) gives the partial transpose of the
%   matrix inputMat, where the dimensions of the (possibly more than 2)
%   subsystems are given by the vector dimArray and the subsystems to take the
%   partial transpose on are given by the scalar or vector sysVec. If inputMat is
%   non-square, different row and column dimensions can be specified by
%   putting the row dimensions in the first row of dimArray and the column
%   dimensions in the second row of dimArray.
%
%   URL: http://www.qetlab.com/PartialTranspose
 
%   requires: QFIEntanglementToolbox.utils.optArgs, QFIEntanglementToolbox.PermuteSystems
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox (Inspired by QETLAB)
 
function outputMat = PartialTranspose(inputMat,varargin)
 
sizeX = size(inputMat);
sqrtSizeX = round(sqrt(sizeX));
 
% set optional argument defaults: sysVec=2, dimArray=round(sqrt(length(inputMat)))
[sysVec,dimArray] = QFIEntanglementToolbox.utils.optArgs({ 2, [sqrtSizeX(1) sqrtSizeX(1);sqrtSizeX(2) sqrtSizeX(2)] },varargin{:});
 
numSys = length(dimArray);
 
% allow the user to enter a single number for dimArray
if(numSys == 1)
    dimArray = [dimArray,sizeX(1)/dimArray];
    if abs(dimArray(2) - round(dimArray(2))) >= 2*sizeX(1)*eps
        error('PartialTranspose:InvalidDim','If DIM is a scalar, X must be square and DIM must evenly divide length(X); please provide the DIM array containing the dimensions of the subsystems.');
    end
    dimArray(2) = round(dimArray(2));
    numSys = 2;
end
 
% allow the user to enter a vector for dimArray if inputMat is square
if(min(size(dimArray)) == 1)
    dimArray = dimArray(:).'; % force dimArray to be a row vector
    dimArray = [dimArray;dimArray];
end
 
% prepare the partial transposition
prodDimR = prod(dimArray(1,:));
prodDimC = prod(dimArray(2,:));
subProdR = prod(dimArray(1,sysVec));
subProdC = prod(dimArray(2,sysVec));
subSysVecR = prodDimR*ones(1,subProdR)/subProdR;
subSysVecC = prodDimC*ones(1,subProdC)/subProdC;
permVec = [sysVec,setdiff(1:numSys,sysVec)];
 
outputMat = QFIEntanglementToolbox.PermuteSystems(inputMat,permVec,dimArray); % permute the subsystems so that we just have to do the partial transpose on the first (potentially larger) subsystem
 
if(isnumeric(outputMat)) % if the input is a numeric matrix, perform the partial transpose operation the fastest way we know how
    outputMat = cell2mat(mat2cell(outputMat, subSysVecR, subSysVecC).'); % partial transpose on first subsystem
else % if the input is not numeric (such as a variable in a semidefinite program), do a slower method that avoids mat2cell (mat2cell doesn't like non-numeric arrays)
    outputMat = reshape(permute(reshape(outputMat,[subSysVecR(1),subProdR,subSysVecC(1),subProdC]),[1,4,3,2]),[prodDimR,prodDimC]);
end
 
% return the subsystems back to their original positions
dimArray(:,sysVec) = dimArray([2,1],sysVec);
dimArray = dimArray(:,permVec);
outputMat = QFIEntanglementToolbox.PermuteSystems(outputMat,permVec,dimArray,0,1);
end
