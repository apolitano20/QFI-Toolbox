function [annihilationOps, creationOps, numberOps] = JordanWignerTransformation(chainLength)
%%  JORDANWIGNERTRANSFORMATION Jordan-Wigner transformation for a L-sites spin chain
%   This function has one required input argument:
%	chainLength: lenght of the spin chian
%
%   [annihilationOps, creationOps, numberOps] = JordanWignerTransformation(chainLength) maps the spin operators of a
%   chainLength-sites chain onto fermionic creation and annihilation operators. Given
%   the system size chainLength, the fucntion returns the corresponding creation and
%   annihilation operators creationOps and annihilationOps and the particle number operator numberOps =
%   creationOps*annihilationOps. 
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	author: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%	BUILDING BLOCKS
	dim = 2^chainLength;
    sX = sparse([0 1 ; 1 0]);    %Pauli X
    sY = sparse([0 -1i ; 1i 0]); %Pauli Y
    sZ = sparse([1 0 ; 0 -1]);   %Pauli Z
%%	MEMORY ALLOCATION    
    sTotX = cell(1,chainLength);
	sTotY = cell(1,chainLength);
    sTotZ = cell(1,chainLength);
    sPlus = cell(1,chainLength);
    sMinus = cell(1,chainLength);
    sPrefactor = cell(1,chainLength);
    creationOps = cell(1,chainLength);
    annihilationOps = cell(1,chainLength);
    numberOps = cell(1,chainLength);
%%  FERMIONIC OPERATOR CONSTRUCTION
    for k = 1:chainLength
        sTotX{k} = kron(kron(eye(2^(k-1)),sX),eye(2^(chainLength-k))); 
        sTotY{k} = kron(kron(eye(2^(k-1)),sY),eye(2^(chainLength-k))); 
        sTotZ{k} = kron(kron(eye(2^(k-1)),sZ),eye(2^(chainLength-k))); 
        sPlus{k} = 1/2*(sTotX{k} + 1i*sTotY{k});
        sMinus{k} = 1/2*(sTotX{k} - 1i*sTotY{k});
        if k == 1
            sPrefactor{1} = speye(dim);
        else
            sPrefactor{k} = sPrefactor{k-1}*(-sTotZ{k-1});
        end
        creationOps{k} = sPrefactor{k}*sPlus{k};
        annihilationOps{k} = sPrefactor{k}*sMinus{k};
        numberOps{k} = creationOps{k}*annihilationOps{k};
    end
end

