function Mag = localMagnetization(state)
%%  LOCALMAGNETIZATION Computes the local expectation value over the input state of the x,y and z components of each spin site.
%   This function has one required input argument:
%	state: the input quantum state
%
%   Mag = localMagnetization(state) returns the local expectation value of
%   the x, y and z component of the spin at each site of a spin chain in a
%   state |state>. The outpit Mag is a L x 3 matrix. The columns correspond
%   to the three compnents x, y and z. Each row correspond to a spin site.
%   Mag_{ij} = <state|S^j_i|state>, i = {1,...,L} j = {x,y,z}.
%     
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

%%  BUILDING BLOCKS
    dim = length(state);
    L = log2(dim);
%%	MEMORY ALLOCATION
    StotX = cell(L,1);
    StotY = cell(L,1);
    StotZ = cell(L,1);
    Mag = zeros(L,3);
    Sx = sparse(0.5*[0 1 ; 1 0]);    %Pauli X
    Sy = sparse(0.5*[0 -1i ; 1i 0]); %Pauli Y
    Sz = sparse(0.5*[1 0 ; 0 -1]);	 %Pauli Z
%%  SPIN OPERATORS CONSTRUCTION
	for k = 1:L
        StotX{k} = kron(kron(speye(2^(k-1)),Sx),speye(2^(L-k)));
        StotY{k} = kron(kron(speye(2^(k-1)),Sy),speye(2^(L-k)));
        StotZ{k} = kron(kron(speye(2^(k-1)),Sz),speye(2^(L-k)));
    end
%%  MAGNETIZATION    
    for k = 1:L
        Mag(k,1) = state'*StotX{k}*state;
        Mag(k,2) = state'*StotY{k}*state;
        Mag(k,3) = state'*StotZ{k}*state;
    end
end
