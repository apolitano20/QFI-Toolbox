function [A, Ac, N] = JordanWignerTransformation(L)
%%  JORDANWIGNERTRANSFORMATION Jordan-Wigner transformation for a L-sites spin chain
%   This function has one required input argument:
%	L: lenght of the spin chian
%
%   [A, Ac, N] = JordanWignerTransformation(L) maps the spin operators of a
%   L-sites chain onto fermionic creation and annihilation operators. Given
%   the system size L, the fucntion returns the corresponding creation and
%   annihilation operators Ac and A and the particle number operator N =
%   Ac*A. 
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: PartialTrace (from the QETLAB package)
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

%%	BUILDING BLOCKS
	dim = 2^L;
    Sx = sparse([0 1 ; 1 0]);    %Pauli X
    Sy = sparse([0 -1i ; 1i 0]); %Pauli Y
    Sz = sparse([1 0 ; 0 -1]);   %Pauli Z
%%	MEMORY ALLOCATION    
    StotX = cell(1,L);
	StotY = cell(1,L);
    StotZ = cell(1,L);
    Sp = cell(1,L);
    Sm = cell(1,L);
    Spref = cell(1,L);
    Ac = cell(1,L);
    A = cell(1,L);
    N = cell(1,L);
%%  FERMIONIC OPERATOR CONSTRUCTION
    for k = 1:L
        StotX{k} = kron(kron(eye(2^(k-1)),Sx),eye(2^(L-k))); 
        StotY{k} = kron(kron(eye(2^(k-1)),Sy),eye(2^(L-k))); 
        StotZ{k} = kron(kron(eye(2^(k-1)),Sz),eye(2^(L-k))); 
        Sp{k} = 1/2*(StotX{k} + 1i*StotY{k});
        Sm{k} = 1/2*(StotX{k} - 1i*StotY{k});
        if k == 1
            Spref{1} = speye(dim);
        else
            Spref{k} = Spref{k-1}*(-StotZ{k-1});
        end
        Ac{k} = Spref{k}*Sp{k};
        A{k} = Spref{k}*Sm{k};
        N{k} = Ac{k}*A{k};
    end
end