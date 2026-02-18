%%  PARTIALTRACE    Computes the partial trace of a matrix
%   This function has one required argument:
%     inputMat: a square matrix
%
%   outputMat = PartialTrace(inputMat) is the partial trace of the matrix inputMat,
%   where it is assumed that length(inputMat) is a perfect squares and both
%   subsystems have equal dimension. The trace is taken over the second
%   subsystem.
%
%   This function has three optional arguments:
%     SYS (default 2)
%     DIM (default has all subsystems of equal dimension)
%     MODE (default -1)
%
%   outputMat = PartialTrace(inputMat,sysVec,dimVec,opMode) gives the partial trace of the matrix inputMat,
%   where the dimensions of the (possibly more than 2) subsystems are given
%   by the vector dimVec and the subsystems to take the trace on are given by
%   the scalar or vector sysVec. opMode is a flag that determines which of two
%   algorithms is used to compute the partial trace. If opMode = -1 then this
%   script chooses whichever algorithm it thinks will be faster based on
%   the dimensions of the subsystems being traced out and the sparsity of
%   inputMat. If you wish to force one specific algorithm, set either opMode = 0
%   (which generally works best for full or non-numeric matrices, or sparse
%   matrices when most of the subsystems are being traced out) or opMode = 1
%   (which generally works best when inputMat is large and sparse, and the partial
%   trace of inputMat will also be large).
%
%   URL: http://www.qetlab.com/PartialTrace
 
%   requires: QFIEntanglementToolbox.utils.optArgs, QFIEntanglementToolbox.PermuteSystems
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox (Inspired by QETLAB)
 
function outputMat = PartialTrace(inputMat,varargin)
 
lenX = length(inputMat);
 
% set optional argument defaults: sysVec=2, dimVec=round(sqrt(length(inputMat))), opMode=-1
[sysVec,dimVec,opMode] = QFIEntanglementToolbox.utils.optArgs({ 2, round(sqrt(lenX)), -1 },varargin{:});
 
numSys = length(dimVec);
 
% allow the user to enter a single number for dimVec
if(numSys == 1)
    dimVec = [dimVec,lenX/dimVec];
    if abs(dimVec(2) - round(dimVec(2))) >= 2*lenX*eps
        error('PartialTrace:InvalidDim','If DIM is a scalar, DIM must evenly divide length(X).');
    end
    dimVec(2) = round(dimVec(2));
    numSys = 2;
end
 
isSparse = issparse(inputMat);
isNumeric = isnumeric(inputMat);
prodDim = prod(dimVec);
prodDimSys = prod(dimVec(sysVec));
 
% Determine which of two computation methods to use (i.e., guess which
% method will be faster).
if(opMode == -1)
    opMode = (isNumeric && isSparse && prodDimSys^2 <= prodDim);
end
 
% If the matrix is sparse and the amount we are tracing over is smaller
% than the amount remaining, just do the naive thing and manually add up
% the blocks.
if(opMode)
    subSysVec = prodDim*ones(1,prodDimSys)/prodDimSys;
    permVec = [sysVec,setdiff(1:numSys,sysVec)];
 
    inputMat = mat2cell(QFIEntanglementToolbox.linalg.PermuteSystems(inputMat,permVec,dimVec), subSysVec, subSysVec); % permute the subsystems so that we just have to do the partial trace on the first (potentially larger) subsystem
    outputMat = sparse(subSysVec(1),subSysVec(1));
    for j = 1:prodDimSys
        outputMat = outputMat + inputMat{j,j};
    end
 
% Otherwise, do a clever trick with mat2cell or reshaping, which is almost always faster.
else
    subProd = prodDim/prodDimSys;
    subSysVec = prodDim*ones(1,subProd)/subProd;
    permVec = [setdiff(1:numSys,sysVec),sysVec];
 
    outputMat = QFIEntanglementToolbox.linalg.PermuteSystems(inputMat,permVec,dimVec); % permute the subsystems so that we just have to do the partial trace on the second (potentially larger) subsystem
 
    if(isNumeric) % if the input is a numeric matrix, perform the partial trace operation the fastest way we know how
        outputMat = cellfun(@(x) full(trace(x)), mat2cell(outputMat, subSysVec, subSysVec)); % partial trace on second subsystem
        if(isSparse) % if input was sparse, output should be too
            outputMat = sparse(outputMat);
        end
    else % if the input is not numeric (such as a variable in a semidefinite program), do a slower method that avoids mat2cell (mat2cell doesn't like non-numeric arrays)
        outputMat = reshape(permute(reshape(outputMat,[subSysVec(1),subProd,subSysVec(1),subProd]),[2,4,1,3]),[subProd,subProd,subSysVec(1)^2]);
        outputMat = sum(outputMat(:,:,1:subSysVec(1)+1:subSysVec(1)^2),3);
    end
end

