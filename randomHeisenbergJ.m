function H = randomHeisenbergJ(L,Jstr,d)
%%  RANDOMHEISENBERGJ Returns the XXZ Heisenberg model Hamiltonian with random interaction strengts
%   This function has two required input arguments:
%     L: the length of the spin chain
%     Jstr: the width of the interval [-Jstr,+Jstr] used to generate the
%     uniformly distributed random interaction strength couplings J. 
%
%   H = randomHeisenbergJ(L,delta) returns the Hamiltonian of the
%   Heisenberg XXZ model with interaction term \Delta = delta and random
%   interaction coefficients per site J ~ U([-Jstr,+J_str]). Periodic
%   boundary conditions
%
%   This function has one optional input argument
%     
%   delta (default 1): anisotropy parameter \Delta.
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

if nargin == 2
    d = 1;
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
%%	Pauli matrices and interaction strengths
    Sx = sparse(0.5*[0 1 ; 1 0]);       %Pauli X
    Sy = sparse(0.5*[0 -1i ; 1i 0]);	%Pauli Y
    Sz = sparse(0.5*[1 0 ; 0 -1]);      %Pauli Z
    J = Jstr*(2*rand(L,1) - 1);
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
                HtempX{k} = J(k)*StotX{k}*StotX{k+1};
                HtempY{k} = J(k)*StotY{k}*StotY{k+1};
                HtempZ{k} = J(k)*StotZ{k}*StotZ{k+1};
            Hx = Hx + HtempX{k};
            Hy = Hy + HtempY{k};
            Hz = Hz + HtempZ{k};
            end
        
	H = -(Hx + Hy + d*Hz);
end