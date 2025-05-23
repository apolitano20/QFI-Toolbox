function [maxQFI, varianceQFI, maxIndex, qfiVal] = stateQFIManual(inputState,elevation,azimuth)
%% STATEQFIMANUAL returns the QFI for the input state |inputState> and a given phase shift generator
%
%	This function has three required input arguments:
%	inputState: the input state (can be a single vector or a matrix where each column is a state)
%	elevation: L x N vector whose l-th entry is the elevation of the
%   Bloch vector on the l-th site for the N-th generator.
%   azimuth: L x N vector, as above.
%
%   [maxQFI, varianceQFI, maxIndex, qfiVal] = stateQFIManual(inputState,elevation,azimuth) returns the
%   quantum Fisher information for the input state |inputState>. The function
%   generates a linear phase shift generator J = 1/2 \sum_{k = 1}^L n_k*sigma_k.
%   n_l = (\alpha_l, \beta_l, gamma_l), l = {1,...,L} is a vector on the
%   Bloch sphere. The inputs "elevation" and "azimuth" are LxN vectors
%   containing the elevation and azimuth coordinates for each of the L
%   sites, for N distinct phase shift generators.
%   
%   Example:
%   >> elevation = 0*ones(4,1); % For L=4, one generator
%   >> azimuth =  pi/2*ones(4,1);
%   >> state = QFIEntanglementToolbox.GHZState(4); % |GHZ> = 1/sqrt(2)(|0000> + |1111>)
%   >> [~,~,~,F_val] = QFIEntanglementToolbox.stateQFIManual(state,elevation,azimuth)
%   >> F_val = 16
%
%   The example above returns the Fisher information for the quantum state
%   |GHZ> (which is a L-partite entangled state) and a phase shift generator
%   constructed through the Bloch vector n_l with the given elevation and
%   azimuth. In this specific example all local directions n_l are the same
%   and they point at the north pole of the sphere. For this configuration
%   the Fisher information is the maximum achievable, thus it corresponds
%   to the quantum Fisher information
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)
%   [2] S.L. Braunstein and C.M. Caves, Phys.Rev.Lett. 72,3439 (1994)

%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: QFIEntanglementToolbox.phaseShiftGenerator
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%  BUILDING BLOCKS and MEMORY ALLOCATION
    [dimState, numStates] = size(inputState);
    chainLength = log2(dimState);
    if mod(length(elevation), chainLength) ~= 0 || mod(length(azimuth), chainLength) ~= 0 || length(elevation) ~= length(azimuth)
        error('Elevation and azimuth vectors must have lengths that are multiples of chainLength (L), and be of equal length.');
    end
    numBlochConfigs = length(elevation)/chainLength; % Number of J operators to generate

    qfiVal = zeros(numStates,numBlochConfigs); % Store QFI for each state and each J
%%  PHASE SHIFT GENERATOR
    % phaseShiftGenerator expects concatenated vectors for multiple configs
    jOperators = QFIEntanglementToolbox.phaseShiftGenerator(chainLength,elevation,azimuth);
%%  FISHER INFORMATION     
	for iConfig = 1:numBlochConfigs
        currentJ = jOperators{iConfig}; % Get the iConfig-th J operator
        currentJSq = currentJ^2;
        
        term1_sum_elements = zeros(numStates,1);
        term2_sum_elements_sq = zeros(numStates,1);

        for iState = 1:numStates
            currentStateVec = inputState(:,iState);
            term1_sum_elements(iState) = currentStateVec' * currentJSq * currentStateVec;
            term2_sum_elements_sq(iState) = (currentStateVec' * currentJ * currentStateVec)^2;
        end
        qfiVal(:,iConfig) = 4*(term1_sum_elements - term2_sum_elements_sq);
	end
	qfiVal = real(qfiVal);
	[maxQFI, maxIndex] = max(qfiVal,[],2); % Max QFI for each state across different J operators
	varianceQFI = var(qfiVal,0,2); % Variance of QFI for each state across different J operators
end
