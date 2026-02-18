function magnetization = localMagnetization(inputState)
%%  LOCALMAGNETIZATION Computes the local expectation value over the input state of the x,y and z components of each spin site.
%   This function has one required input argument:
%	inputState: the input quantum state
%
%   magnetization = localMagnetization(inputState) returns the local expectation value of
%   the x, y and z component of the spin at each site of a spin chain in a
%   state |inputState>. The outpit magnetization is a L x 3 matrix. The columns correspond
%   to the three compnents x, y and z. Each row correspond to a spin site.
%   magnetization_{ij} = <inputState|S^j_i|inputState>, i = {1,...,L} j = {x,y,z}.
%     
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%  BUILDING BLOCKS
    dim = length(inputState);
    chainLength = log2(dim);
%%	MEMORY ALLOCATION
    sTotX = cell(chainLength,1);
    sTotY = cell(chainLength,1);
    sTotZ = cell(chainLength,1);
    magnetization = zeros(chainLength,3);
    sX = sparse(0.5*[0 1 ; 1 0]);    %Pauli X
    sY = sparse(0.5*[0 -1i ; 1i 0]); %Pauli Y
    sZ = sparse(0.5*[1 0 ; 0 -1]);	 %Pauli Z
%%  SPIN OPERATORS CONSTRUCTION
	for k = 1:chainLength
        sTotX{k} = kron(kron(speye(2^(k-1)),sX),speye(2^(chainLength-k)));
        sTotY{k} = kron(kron(speye(2^(k-1)),sY),speye(2^(chainLength-k)));
        sTotZ{k} = kron(kron(speye(2^(k-1)),sZ),speye(2^(chainLength-k)));
    end
%%  MAGNETIZATION    
    for k = 1:chainLength
        magnetization(k,1) = inputState'*sTotX{k}*inputState;
        magnetization(k,2) = inputState'*sTotY{k}*inputState;
        magnetization(k,3) = inputState'*sTotZ{k}*inputState;
    end
end

