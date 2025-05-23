function [jFullEnsemble, blochConfigs] = phaseShiftEnsemble(chainLength,numBlochVec,distributionType)
%% PHASESHIFTENSEMBLE returns an ensemble of phase shift generator operators
%           
%	This function has three required input arguments:
%	chainLength: lenght of the spin chain.
%	numBlochVec: number of generated operators
%   distributionType: probability distribution function for the orientation of the
%   Bloch vectors
%
%   [jFullEnsemble, blochConfigs] = phaseShiftEnsemble(chainLength,numBlochVec,distributionType) returns an
%   ensemble of phase shift generators J = 1/2 \sum_{k = 1}^L n_k*sigma_k,
%   with n_k*sigma_k = \alpha_k*\sigma^x_k + \beta_k*\sigma^y_k +
%   \gamma_k*\sigma^z_k. n_k = (\alpha^x_k,\beta^y_k,\gamma^z_k) is a
%   vector on the Bloch sphere and \sigma = (\sigma^x,\sigma^y,\sigma^z)
%   is the vector of the Pauli matrices associated with the spin l. The
%   Bloch vectors in n_l are randomly generated from the distribtuin "distributionType".
%   distributionType accepts five options: 1. uniform: the Bloch vectors are uniformly
%   distributed over the Bloch sphere. 2. XY: concentrated at the equator
%   of the Bloch sphere. 3. polar: concentrated at the poles. 4.
%   equatorial: concentated around the pole. 5. homogeneous: randomly
%   distributed over the bloch sphere but al the vectors in n_l have the
%   same orientation.
%
%	References:
%   [1] P.Hyllus et al, Phys.Rev.A 85, 022321(2012)
%
%	URL: https://github.com/apolitano20/QFI-Toolbox
 
%	requires: QFIEntanglementToolbox.utils.randPdf
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFIEntanglementToolbox

%%	Building blocks definitions
    dim = 2^chainLength;
    sigmaX = sparse([0 1 ; 1 0]);
    sigmaY = sparse([0 -1i ; 1i 0]);
    sigmaZ = sparse([1 0 ; 0 -1]);
%%	Memory allocation
    sTotX = cell(chainLength,1);
    sTotY = cell(chainLength,1);
    sTotZ = cell(chainLength,1);
    jFullEnsemble = cell(numBlochVec,1);
    jTempComponents = cell(chainLength,1);
%%	Bloch sphere vectors
	rng(0,'twister') %reproducible experiments
	switch distributionType
%	OPZIONE 1 "Distribuzione uniforme sulla sfera"                   
	case 'uniform'
	radius = 1;
	rValues = 2*rand(chainLength*numBlochVec,1)-1;
	elevation = asin(rValues);
	azimuth = 2*pi*rand(chainLength*numBlochVec,1);
	[x,y,z] = sph2cart(azimuth,elevation,radius);
	blochConfigs = mat2cell([x,y,z],chainLength*ones(1,numBlochVec));
%	OPZIONE 2 "Distribuzione uniforme equatoriale"
	case 'XY'
	radius = 1;
	elevation = zeros(chainLength*numBlochVec,1);
	azimuth = 2*pi*rand(chainLength*numBlochVec,1);
	[x,y,z] = sph2cart(azimuth,elevation,radius);
	blochConfigs = mat2cell([x,y,z],chainLength*ones(1,numBlochVec));
	case 'polar'
%	OPZIONE 3 "Distribuzione polare"
	radius = 1;
	pxVec = linspace(0,pi,70);
	elevation = QFIEntanglementToolbox.utils.randPdf(80/(pi^5)*(pxVec-pi/2).^4,pxVec,[chainLength*numBlochVec,1]);
	azimuth = 2*pi*rand(chainLength*numBlochVec,1);
	x  = radius.*sin(elevation).*cos(azimuth);
	y = radius.*sin(elevation).*sin(azimuth);
	z = radius.*cos(elevation);
	blochConfigs = mat2cell([x,y,z],chainLength*ones(1,numBlochVec));
%	OPZIONE 4 "Distribuzione equatoriale"
	case 'equatorial'
	radius = 1;
	n = 7;
	pxVec = linspace(0,pi,70);
	elevation = QFIEntanglementToolbox.utils.randPdf(n/(2-2*exp(-n*pi/2))*exp(-n*abs(pxVec-pi/2)),pxVec,[chainLength*numBlochVec,1]);
	azimuth = 2*pi*rand(chainLength*numBlochVec,1);
	x  = radius.*sin(elevation).*cos(azimuth);
	y = radius.*sin(elevation).*sin(azimuth);
	z = radius.*cos(elevation);
	blochConfigs = mat2cell([x,y,z],chainLength*ones(1,numBlochVec));
%	OPZIONE 5 "Distribuzione omogenea"
	case 'homogeneous'
	radius = 1;
	rValues = 2*rand(numBlochVec,1)-1;
	elevation = asin(rValues);
	elevation = kron(elevation,ones(chainLength,1));
	azimuth = 2*pi*rand(numBlochVec,1);
	azimuth = kron(azimuth,ones(chainLength,1));
	[x,y,z] = sph2cart(azimuth,elevation,radius);
	blochConfigs = mat2cell([x,y,z],chainLength*ones(1,numBlochVec));
    otherwise
        error('Unknown distribution type: %s', distributionType);
	end
%% Spin operators
	for k = 1:chainLength
        sTotX{k} = kron(kron(speye(2^(k-1)),sigmaX),speye(2^(chainLength-k)));
        sTotY{k} = kron(kron(speye(2^(k-1)),sigmaY),speye(2^(chainLength-k)));
        sTotZ{k} = kron(kron(speye(2^(k-1)),sigmaZ),speye(2^(chainLength-k)));
	end
        %% Construction of the operator J
for k = 1:numBlochVec
    jFullEnsemble{k} = sparse(dim,dim);
    for jj = 1:chainLength
        jTempComponents{jj} = 1/2*(blochConfigs{k}(jj,1)*sTotX{jj} + blochConfigs{k}(jj,2)*sTotY{jj} + blochConfigs{k}(jj,3)*sTotZ{jj});
        jFullEnsemble{k} = jFullEnsemble{k} + jTempComponents{jj};
    end
end
end
