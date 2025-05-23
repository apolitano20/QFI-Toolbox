function orderParamValue = orderParameter(inputState,parameterType)
%%  ORDERPARAMETER returns the order parameter for a spin chain in the state |inputState>
%	This function has two required input argument:
%	inputState: the input quantum state 
%   parameterType: 'fm' for ferromagnetic, 'af' for antiferromagnetic
%
%   orderParamValue = orderParameter(inputState,parameterType) returns the order parameter of a spin
%   chain in the state |inputState>. The input "parameterType" can take three values:
%   'fm', 'af' and 'r'. When parameterType = 'fm' the function compute the order
%   parameter of the ferromagnetic phase, namely the average magnetization
%   along the z direction. When parameterType = 'af' the order parameter is the
%   average of the staggered magnetization.
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%  Building blocks
    chainLength = log2(length(inputState));
    sigmaZ = 0.5*[1 0;0 -1];
    switch parameterType 
        case 'af'
            coefficients = repmat([+1;-1],chainLength/2,1);
        case 'fm'
            coefficients = ones(chainLength,1);
        otherwise
            error('Invalid order parameter type. Choose "fm" or "af".');
    end 
%%  Memory allocation
    opTemp = zeros(chainLength,1);
%%  Order Parameter construction
    for k = 1:chainLength
        opTemp(k) = inputState'*(coefficients(k)*kron(kron(eye(2^(k-1)),sigmaZ), ...
            eye(2^(chainLength-k))))*inputState;
    end
    orderParamValue = 1/chainLength*sum(opTemp);
end
