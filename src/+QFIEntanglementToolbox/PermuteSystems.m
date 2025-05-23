%%  PERMUTESYSTEMS    Permutes subsystems within a state or operator
%   This function has two required arguments:
%     inputArg: the vector or matrix
%     permVec: a permutation vector
%
%   outputArg = PermuteSystems(inputArg,permVec) permutes the order of the subsystems
%   of the vector or matrix inputArg according to the permutation vector permVec,
%   where each subsystem is assumed to have equal dimension
%
%   This function has three optional arguments:
%     dimArray (default has all subsystems of equal dimension)
%     rowOnly (default 0)
%     invPerm (default 0)
%   
%   outputArg = PermuteSystems(inputArg,permVec,dimArray,rowOnly,invPerm) permutes the order of
%   the subsystems of the vector or matrix inputArg according to the permutation
%   vector permVec, where the dimensions of the subsystems are given by the
%   vector dimArray. If inputArg is non-square and not a vector, different row and
%   column dimensions can be specified by putting the row dimensions in the
%   first row of dimArray and the column dimensions in the second row of dimArray.
%   If rowOnly is set to 1, then only the rows of inputArg are permuted, but not
%   the columns -- this is equivalent tomultiplying inputArg on the left by the
%   corresponding permutation operator, but not on the right. If rowOnly
%   is set to 1 then dimArray only needs to contain the row dimensions of the
%   subsystems, even if inputArg is not square. If invPerm equals 1 then the
%   inverse permutation of permVec is applied instead of permVec itself.
%
%   URL: http://www.qetlab.com/PermuteSystems
 
%   requires: QFIEntanglementToolbox.utils.optArgs
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox (Inspired by QETLAB)
 
function outputArg = PermuteSystems(inputArg,permVec,varargin)
 
sizeX = size(inputArg);
isVec = (min(sizeX) == 1);
numSys = length(permVec);
if(isVec)
    vecOrien = 3 - find(sizeX == 1, 1); % 1 if column vector, 2 if row vector
end
 
% set optional argument defaults: dimArray=round(lX^(1/numSys)), rowOnly=0, invPerm=0
[dimArray,rowOnly,invPerm] = QFIEntanglementToolbox.utils.optArgs({ [round(sizeX(1)^(1/numSys))*ones(1,numSys); round(sizeX(2)^(1/numSys))*ones(1,numSys)], 0, 0 },varargin{:});
 
% allow the user to enter a vector for dimArray if inputArg is square
if(min(size(dimArray)) == 1)
    dimTmp = dimArray(:)'; % force dimArray to be a row vector
    if(isVec)
        dimArray = ones(2,length(dimArray));
        dimArray(vecOrien,:) = dimTmp;
    else
        dimArray = [dimTmp;dimTmp];
    end
end
 
prodDimR = prod(dimArray(1,:));
prodDimC = prod(dimArray(2,:));
 
% Do some basic input checking.
if length(permVec) ~= numSys
    error('PermuteSystems:InvalidPerm','length(PERM) must equal length(DIM).')
elseif ~all(sort(permVec) == 1:numSys)
    error('PermuteSystems:InvalidPerm','PERM must be a permutation vector.')
elseif(sizeX(1) ~= prodDimR || (~rowOnly && sizeX(2) ~= prodDimC))
    error('PermuteSystems:InvalidDim','The dimensions specified in DIM do not agree with the size of X.')
end
 
% Permuting systems for pure states is easy enough, so just make the vector
% full and then perform the permutation (new-ish versions of MATLAB don't
% like sparse multidimensional arrays).
if(isVec)
    if(invPerm)
        outputArg = reshape(ipermute(reshape(full(inputArg),dimArray(vecOrien,end:-1:1)),numSys+1-permVec(end:-1:1)),sizeX);
    else
        outputArg = reshape(permute(reshape(full(inputArg),dimArray(vecOrien,end:-1:1)),numSys+1-permVec(end:-1:1)),sizeX);
    end
 
    % Preserve the sparsity of inputArg.
    if(issparse(inputArg))
        outputArg = sparse(outputArg);
    end
    return
end
 
% If inputArg is not a pure state, it's slightly trickier... do *not* just use the
% same pure state trick with repeated indices though, since that has an
% intermediate step of making the matrix a multidimensional array, which
% you can't do with sparse matrices in new-ish version of MATLAB. The trick
% used here reduces the problem to the pure state version of the problem in
% another way that plays nicely with both full and sparse matrices
rowPerm = PermuteSystems(1:sizeX(1),permVec,dimArray(1,:),0,invPerm);
outputArg = inputArg(rowPerm,:);
if ~rowOnly
    colPerm = PermuteSystems(1:sizeX(2),permVec,dimArray(2,:),0,invPerm);
    outputArg = outputArg(:,colPerm);
end
