function bitTable = indexToBits(indices, numBits, leftMsb)
%INDEXTOBITS Convert non-negative integer indices to fixed-width bits.
%   bitTable = indexToBits(indices, numBits) returns a matrix of size
%   numel(indices)-by-numBits with one binary row per index.
%
%   bitTable = indexToBits(indices, numBits, leftMsb) controls bit order.
%   If leftMsb is true (default), the leftmost column is the MSB.
%
% package: QFIEntanglementToolbox.utils

if nargin < 3
    leftMsb = true;
end

idx = double(indices(:));
if any(idx < 0) || any(abs(idx - round(idx)) > 0)
    error('QFIEntanglementToolbox:indexToBits:InvalidIndex', ...
        'indices must be non-negative integers.');
end
if ~isscalar(numBits) || numBits < 1 || abs(numBits - round(numBits)) > 0
    error('QFIEntanglementToolbox:indexToBits:InvalidNumBits', ...
        'numBits must be a positive integer scalar.');
end

powers = 2.^(numBits-1:-1:0);
bitTable = mod(floor(idx ./ powers), 2);
if ~leftMsb
    bitTable = fliplr(bitTable);
end
end
