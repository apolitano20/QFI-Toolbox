function H = heisenbergXXZ(chainLength,deltaAnisotropy)
%%  HEISENBERGXXZ  Returns the Heisenberg XXZ model Hamiltonian
%   This function has one required input argument:
%     chainLength: the length of the spin chain
%
%   H = heisenbergXXZ(chainLength,deltaAnisotropy) returns the Hamiltonian of the Heisenberg
%   XXZ model with interaction term \Delta = deltaAnisotropy. Periodic boundary
%   conditions are imposed. Given the exponential growth of the Hamiltonian
%   and the its sparse nature, the output has a sparse form.
%
%   This function has one optional input argument
%     
%   deltaAnisotropy (default 1): anisotropy parameter \Delta
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

    if nargin == 1
        deltaAnisotropy = 1;
    end
    
%%  Memory allocation
    dim = 2^chainLength;
    sTotX = cell(1,chainLength+1);
    sTotY = cell(1,chainLength+1);
    sTotZ = cell(1,chainLength+1);
    hTempX = cell(1,chainLength); 
    hTempY = cell(1,chainLength); 
    hTempZ = cell(1,chainLength); 
    hX = sparse(dim,dim);
    hY = sparse(dim,dim);
    hZ = sparse(dim,dim);
    
%%	Pauli matrices
    sX = sparse(0.5*[0 1 ; 1 0]);       %Pauli X
    sY = sparse(0.5*[0 -1i ; 1i 0]);	%Pauli Y
    sZ = sparse(0.5*[1 0 ; 0 -1]);      %Pauli Z
%%  Spin operators construction
        for k = 1:chainLength
            sTotX{k} = kron(kron(speye(2^(k-1)),sX),speye(2^(chainLength-k))); 
            sTotY{k} = kron(kron(speye(2^(k-1)),sY),speye(2^(chainLength-k))); 
            sTotZ{k} = kron(kron(speye(2^(k-1)),sZ),speye(2^(chainLength-k))); 
        end
%	Periodic boundary conditions
              sTotX{chainLength+1} = sTotX{1};
              sTotY{chainLength+1} = sTotY{1};
              sTotZ{chainLength+1} = sTotZ{1};
%%	Hamiltonian construction
            for k = 1:chainLength
                hTempX{k} = sTotX{k}*sTotX{k+1};
                hTempY{k} = sTotY{k}*sTotY{k+1};
                hTempZ{k} = sTotZ{k}*sTotZ{k+1};
            hX = hX + hTempX{k};
            hY = hY + hTempY{k};
            hZ = hZ + hTempZ{k};
            end
%   XXZ Heisenberg Hamiltonian
	H = -(hX + hY + deltaAnisotropy*hZ);
end
