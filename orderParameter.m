function OP = orderParameter(state,type)
%%  ORDERPARAMETER returns the order parameter for a spin chain in the state |state>
%	This function has two required input argument:
%	rho: the input quantum state 
%
%   OP = orderParameter(state,type) returns the order parameter of a spin
%   chain in the state |state>. The input "type" can take three values:
%   'fm', 'af' and 'r'. When type = 'fm' the function compute the order
%   parameter of the ferromagnetic phase, namely the average magnetization
%   along the z direction. When type = 'af' the order parameter is the
%   average of the staggered magnetization.
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

%%  Building blocks
    L = log2(length(state));
    Z = 0.5*[1 0;0 -1];
    switch type 
        case 'af'
            coeff = repmat([+1;-1],L/2,1);
        case 'fm'
            coeff = ones(L,1);
    end 
%%  Memory allocation
    OP_temp = zeros(L,1);
%%  Order Parameter construction
    for k = 1:L
        OP_temp(k) = state'*(coeff(k)*kron(kron(eye(2^(k-1)),Z), ...
            eye(2^(L-k))))*state;
    end
    OP = 1/L*sum(OP_temp);
end