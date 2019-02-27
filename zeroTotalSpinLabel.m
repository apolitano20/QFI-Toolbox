function stateLabel = zeroTotalSpinLabel(L)
%% ZEROTOTALSPINLABEL returns the label of the states in the computational base having zero total spin
%           
%	This function has one required input arguments:
%	L: lenght of the spin chain.
%
%   stateLabel = zeroTotalSpinLabel(L) returns the labels of the
%   computational basis vectos whose total spin along the z direction is
%   equal to zero. 
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 27, 2019
 
	if mod(L,2) == 1
        disp('There are no zero total-spin states for an odd number of sites');
        return
    else
        dim = 2^L; %dimension total hilbert space
        v = (1:2^L)';
        V = zeros(dim,L,'int8');
        for i = 1:L
            z = zeros(dim/2^i,1,'int8');
            o = ones(dim/2^i,1,'int8');
            V(:,i) = repmat([z;o],[2^(i-1),1]);
        end
        stot = sum(10*V-5,2);
        stateLabel = v(stot == 0);
	end
    
end