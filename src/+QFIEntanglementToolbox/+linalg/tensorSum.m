%%  TENSORSUM  Computes a vector or operator from its tensor decomposition
%   This function can be called in two ways:
%   tensorSumOutput = tensorSum(inputA1,inputA2,...)
%   tensorSumOutput = tensorSum(coefficients,inputA1,inputA2,...)
%
%   Each term Ai is either a matrix or a cell containing matrices (and they
%   should all be the same: either all matrices or all cells). If they are
%   matrices, then the k-th column of each Ai will be tensored together for
%   all k, and then the sum over k will be taken at the end. If they are
%   cells, then the k-th element of each Ai will be tensored together for
%   all k, and then the sum over k will be taken at the end.
%
%   If coefficients is provided, it is a vector of weights (such as Schmidt
%   coefficients) that will be applied when summing the terms at the end of
%   the computation.
%
%   This function acts as an inverse of the SchmidtDecomposition and
%   OperatorSchmidtDecomposition functions. For example, if [S,U,V] =
%   SchmidtDecomposition(VEC) then VEC = tensorSum(S,U,V).
%
%   URL: http://www.qetlab.com/TensorSum
 
%   requires: nothing
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox (Inspired by QETLAB)
 
function tensorSumOutput = tensorSum(inputA1,inputA2,varargin)
 
% Determine the number of terms in the tensor decomposition.
if(iscell(inputA2))
    numTerms = length(inputA2);
else
    numTerms = size(inputA2,2);
end
 
% Determine whether or not a vector of coefficients was provided, then read
% in the input arguments.
if(iscell(inputA1) || min(size(inputA1)) > 1 || numTerms == 1)
    coefficients = ones(numTerms,1);
    inputCells = [{inputA1} {inputA2} varargin];
else
    coefficients = inputA1;
    inputCells = [{inputA2} varargin];
end
 
% Get some more preliminary values (dimensions, etc.) and then convert
% everything into cell matrices (instead of matrices of column vectors) if
% necessary.
numParties = length(inputCells);
dims = zeros(2,numParties);
for j = 1:numParties
    if(~iscell(inputCells{j}))
        inputCells{j} = mat2cell(inputCells{j},size(inputCells{j},1),ones(1,size(inputCells{j},2)));
    end
    dims(:,j) = size(inputCells{j}{1}).';
end
 
% Finally, actually compute the tensor sum.
tensorSumOutput = sparse(prod(dims(1,:)),prod(dims(2,:)));
for j = 1:numTerms
    tsTemp = inputCells{1}{j};
    for k = 2:numParties
        tsTemp = kron(tsTemp,inputCells{k}{j});
    end
    tensorSumOutput = tensorSumOutput + coefficients(j)*tsTemp;
end

