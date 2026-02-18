function stateLabels = zeroTotalSpinLabel(chainLength)
%% ZEROTOTALSPINLABEL returns the label of the states in the computational base having zero total spin
%           
%	This function has one required input arguments:
%	chainLength: lenght of the spin chain.
%
%   stateLabels = zeroTotalSpinLabel(chainLength) returns the labels of the
%   computational basis vectos whose total spin along the z direction is
%   equal to zero. 
%
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox
 
	if mod(chainLength,2) == 1
        disp('There are no zero total-spin states for an odd number of sites');
        stateLabels = []; % Return empty if no such states
        return
    else
        dimHilbertSpace = 2^chainLength; %dimension total hilbert space
        indexVector = (1:dimHilbertSpace)';
        % V will store the binary representation (0 or 1) for each site for each state
        binaryMatrix = zeros(dimHilbertSpace,chainLength,'int8'); 
        for i = 1:chainLength
            zerosBlock = zeros(dimHilbertSpace/2^i,1,'int8');
            onesBlock = ones(dimHilbertSpace/2^i,1,'int8');
            binaryMatrix(:,i) = repmat([zerosBlock;onesBlock],[2^(i-1),1]);
        end
        % Original logic: sum(10*V-5,2) checks for sum(2*V-1,2) == 0
        % This means an equal number of 0s and 1s (down and up spins)
        sTotalZ_scaled = sum(10*binaryMatrix-5,2); 
        stateLabels = indexVector(sTotalZ_scaled == 0);
	end
    
end

