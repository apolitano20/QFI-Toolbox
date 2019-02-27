function H = heisenbergXXZ(L,delta)
%%  HEISENBERGXXZ  Returns the Heisenberg XXZ model Hamiltonian
%   This function has one required input argument:
%     L: the length of the spin chain
%
%   H = heisenbergXXZ(L,delta) returns the Hamiltonian of the Heisenberg
%   XXZ model with interaction term \Delta = delta. Periodic boundary
%   conditions are imposed. Given the exponential growth of the Hamiltonian
%   and the its sparse nature, the output has a sparse form.
%
%   This function has one optional input argument
%     
%   delta (default 1): anisotropy parameter \Delta
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

    if nargin == 1
        delta = 1;
    end
    
%%  Memory allocation
    dim = 2^L;
    StotX = cell(1,L+1);
    StotY = cell(1,L+1);
    StotZ = cell(1,L+1);
    HtempX = cell(1,L); 
    HtempY = cell(1,L); 
    HtempZ = cell(1,L); 
    Hx = sparse(dim,dim);
    Hy = sparse(dim,dim);
    Hz = sparse(dim,dim);
    
%%	Pauli matrices
    Sx = sparse(0.5*[0 1 ; 1 0]);       %Pauli X
    Sy = sparse(0.5*[0 -1i ; 1i 0]);	%Pauli Y
    Sz = sparse(0.5*[1 0 ; 0 -1]);      %Pauli Z
%%  Spin operators construction
        for k = 1:L
            StotX{k} = kron(kron(speye(2^(k-1)),Sx),speye(2^(L-k))); 
            StotY{k} = kron(kron(speye(2^(k-1)),Sy),speye(2^(L-k))); 
            StotZ{k} = kron(kron(speye(2^(k-1)),Sz),speye(2^(L-k))); 
        end
%	Periodic boundary conditions
              StotX{L+1} = StotX{1};
              StotY{L+1} = StotY{1};
              StotZ{L+1} = StotZ{1};
%%	Hamiltonian construction
            for k = 1:L
                HtempX{k} = StotX{k}*StotX{k+1};
                HtempY{k} = StotY{k}*StotY{k+1};
                HtempZ{k} = StotZ{k}*StotZ{k+1};
            Hx = Hx + HtempX{k};
            Hy = Hy + HtempY{k};
            Hz = Hz + HtempZ{k};
            end
%   XXZ Heisenberg Hamiltonian
	H = -(Hx + Hy + delta*Hz);
end