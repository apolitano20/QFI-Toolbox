function jManualEnsemble = phaseShiftGenerator(chainLength,elevation,azimuth)
%% PHASESHIFTGENERATOR returns a phase shift generator operator 
%           
%   This function has three required input arguments:
%	chainLength: lenght of the spin chain.
%	elevation: chainLength x 1 vector whose l-th entry is the elevation of the
%   Bloch vector on the l-th site.
%   azimuth: chainLength x 1 vector, as above.
%
%   jManualEnsemble = phaseShiftGenerator(chainLength, elevation, azimuth) returns the linear
%   phase shift generator operator J = 1/2 \sum_{k = 1}^L n_k*sigma_k,
%   with n_k*sigma_k = \alpha_k*\sigma^x_k + \beta_k*\sigma^y_k +
%   \gamma_k*\sigma^z_k. n_k = (\alpha^x_k,\beta^y_k,\gamma^z_k) is a
%   vector on the Bloch sphere and \sigma = (\sigma^x,\sigma^y,\sigma^z)
%   ist the vector of the Pauli matrices associated with the spin l. 
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: nothing
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%	Building blocks definitions
    dim = 2^chainLength;
    % Assuming elevation and azimuth are for a single configuration, not an ensemble.
    % If they represent an ensemble, numBlochVec should be an input or determined differently.
    % For now, assuming inputs are for one generator, so numBlochVec = 1.
    % If elevation is L*N long for N vectors, then:
    if mod(length(elevation), chainLength) ~= 0
        error('Length of elevation vector must be a multiple of chainLength.');
    end
    numBlochVec = length(elevation)/chainLength;

    sigmaX = sparse([0 1 ; 1 0]);
    sigmaY = sparse([0 -1i ; 1i 0]);
    sigmaZ = sparse([1 0 ; 0 -1]);
%%	Memory allocation
    sTotX = cell(chainLength,1);
    sTotY = cell(chainLength,1);
    sTotZ = cell(chainLength,1);
    jManualEnsemble = cell(numBlochVec,1);
    jBenchTemp = cell(chainLength,1); % Corrected variable name
%%	Bloch sphere vectors
	radius = 1;
	[x,y,z] = sph2cart(azimuth,elevation,radius);
    % Reshape x,y,z if numBlochVec > 1 to match expected structure by mat2cell
    if numBlochVec > 1
        x = reshape(x, chainLength, numBlochVec);
        y = reshape(y, chainLength, numBlochVec);
        z = reshape(z, chainLength, numBlochVec);
        tempBlochConfigs = cell(1,numBlochVec);
        for iVec = 1:numBlochVec
            tempBlochConfigs{iVec} = [x(:,iVec), y(:,iVec), z(:,iVec)];
        end
        blochConfigs = tempBlochConfigs;
    else
	    blochConfigs = mat2cell([x,y,z],chainLength*ones(1,numBlochVec));
    end
%% Spin operators
	for k = 1:chainLength
        sTotX{k} = kron(kron(speye(2^(k-1)),sigmaX),speye(2^(chainLength-k)));
        sTotY{k} = kron(kron(speye(2^(k-1)),sigmaY),speye(2^(chainLength-k)));
        sTotZ{k} = kron(kron(speye(2^(k-1)),sigmaZ),speye(2^(chainLength-k)));
	end
%%	Construction of the operator J
for k = 1:numBlochVec
    jManualEnsemble{k} = sparse(dim,dim);
    currentBlochConfig = blochConfigs{k}; % Get the k-th configuration
    for jj = 1:chainLength
        jBenchTemp{jj} = 1/2*(currentBlochConfig(jj,1)*sTotX{jj} + currentBlochConfig(jj,2)*sTotY{jj} + currentBlochConfig(jj,3)*sTotZ{jj});
        jManualEnsemble{k} = jManualEnsemble{k} + jBenchTemp{jj};
    end
end
end

