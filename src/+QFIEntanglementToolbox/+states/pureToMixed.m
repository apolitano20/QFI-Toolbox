%%  pureToMixed    Converts a state vector or density matrix representation of a state to a density matrix
%   This function has one required argument:
%     inputState: a density matrix or a pure state vector
%
%   outputDensityMatrix = pureToMixed(inputState) is a density matrix representation of inputState,
%   regardless of whether inputState is itself already a density matrix, or if it
%   is a pure state vector.
%
%   URL: http://www.qetlab.com/pure_to_mixed
 
%   requires: nothing
%   author: Nathaniel Johnston (nathaniel@njohnston.ca)
%   package: QFIEntanglementToolbox (Inspired by QETLAB)
 
function outputDensityMatrix = pureToMixed(inputState)
 
% Compute the size of inputState. If it's already a mixed state, leave it alone.
% If it's a vector (pure state), make it into a density matrix.
[numRows,numCols] = size(inputState);
 
if(min(numRows,numCols) == 1) % it's a pure state vector
    inputStateVec = inputState(:); % Ensure it's a column vector
    outputDensityMatrix = inputStateVec*inputStateVec';
elseif(numRows == numCols) % it's a density matrix
    outputDensityMatrix = inputState;
else % it's neither
    error('pureToMixed:InvalidDimensions','inputState must be either a vector or a square matrix.');
end

