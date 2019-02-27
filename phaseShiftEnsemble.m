function [Jfull, blochConfig] = phaseShiftEnsemble(L,nBlochVec,distr)
%% PHASESHIFTENSEMBLE returns an ensemble of phase shift generator operators
%           
%	This function has three required input arguments:
%	L: lenght of the spin chain.
%	nBlochVec: number of generated operators
%   distr: probability distribution function for the orientation of the
%   Bloch vectors
%
%   [Jfull, blochConfig] = phaseShiftEnsemble(L,nBlochVec,distr) returns an
%   ensemble of phase shift generators J = 1/2 \sum_{k = 1}^L n_k*sigma_k,
%   with n_k*sigma_k = \alpha_k*\sigma^x_k + \beta_k*\sigma^y_k +
%   \gamma_k*\sigma^z_k. n_k = (\alpha^x_k,\beta^y_k,\gamma^z_k) is a
%   vector on the Bloch sphere and \sigma = (\sigma^x,\sigma^y,\sigma^z)
%   is the vector of the Pauli matrices associated with the spin l. The
%   Bloch vectors in n_l are randomly generated from the distribtuin "distr".
%   distr accepts five options: 1. uniform: the Bloch vectors are uniformly
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
 
%	requires: nothing
% 	authors: Andrea Politano (a.politano20@gmail.com)
%	package: QFI Toolbox 
%	last updated: February 26, 2019

%%	Building blocks definitions
    dim = 2^L;
    sigma_x = sparse([0 1 ; 1 0]);
    sigma_y = sparse([0 -1i ; 1i 0]);
    sigma_z = sparse([1 0 ; 0 -1]);
%%	Memory allocation
    StotX = cell(L,1);
    StotY = cell(L,1);
    StotZ = cell(L,1);
    Jfull = cell(nBlochVec,1);
    Jtemp = cell(L,1);
%%	Bloch sphere vectors
	rng(0,'twister') %reproducible experiments
	switch distr
%	OPZIONE 1 "Distribuzione uniforme sulla sfera"                   
	case 'uniform'
	radius = 1;
	rvals = 2*rand(L*nBlochVec,1)-1;
	elevation = asin(rvals);
	azimuth = 2*pi*rand(L*nBlochVec,1);
	[x,y,z] = sph2cart(azimuth,elevation,radius);
	blochConfig = mat2cell([x,y,z],L*ones(1,nBlochVec));
%	OPZIONE 2 "Distribuzione uniforme equatoriale"
	case 'XY'
	radius = 1;
	elevation = zeros(L*nBlochVec,1);
	azimuth = 2*pi*rand(L*nBlochVec,1);
	[x,y,z] = sph2cart(azimuth,elevation,radius);
	blochConfig = mat2cell([x,y,z],L*ones(1,nBlochVec));
	case 'polar'
%	OPZIONE 3 "Distribuzione polare"
	radius = 1;
	px = linspace(0,pi,70);
	elevation = randpdf(80/(pi^5)*(px-pi/2).^4,px,[L*nBlochVec,1]);
	azimuth = 2*pi*rand(L*nBlochVec,1);
	x  = radius.*sin(elevation).*cos(azimuth);
	y = radius.*sin(elevation).*sin(azimuth);
	z = radius.*cos(elevation);
	blochConfig = mat2cell([x,y,z],L*ones(1,nBlochVec));
%	OPZIONE 4 "Distribuzione equatoriale"
	case 'equatorial'
	radius = 1;
	n = 7;
	px = linspace(0,pi,70);
	elevation = randpdf(n/(2-2*exp(-n*pi/2))*exp(-n*abs(px-pi/2)),px,[L*nBlochVec,1]);
	azimuth = 2*pi*rand(L*nBlochVec,1);
	x  = radius.*sin(elevation).*cos(azimuth);
	y = radius.*sin(elevation).*sin(azimuth);
	z = radius.*cos(elevation);
	blochConfig = mat2cell([x,y,z],L*ones(1,nBlochVec));
%	OPZIONE 5 "Distribuzione omogenea"
	case 'homogeneous'
	radius = 1;
	rvals = 2*rand(nBlochVec,1)-1;
	elevation = asin(rvals);
	elevation = kron(elevation,ones(L,1));
	azimuth = 2*pi*rand(nBlochVec,1);
	azimuth = kron(azimuth,ones(L,1));
	[x,y,z] = sph2cart(azimuth,elevation,radius);
	blochConfig = mat2cell([x,y,z],L*ones(1,nBlochVec));
	end
%% Spin operators
	for k = 1:L
        StotX{k} = kron(kron(speye(2^(k-1)),sigma_x),speye(2^(L-k)));
        StotY{k} = kron(kron(speye(2^(k-1)),sigma_y),speye(2^(L-k)));
        StotZ{k} = kron(kron(speye(2^(k-1)),sigma_z),speye(2^(L-k)));
	end
        %% Construction of the operator J
for k = 1:nBlochVec
    Jfull{k} = sparse(dim,dim);
    for jj = 1:L
        Jtemp{jj} = 1/2*(blochConfig{k}(jj,1)*StotX{jj} + blochConfig{k}(jj,2)*StotY{jj} + blochConfig{k}(jj,3)*StotZ{jj});
        Jfull{k} = Jfull{k} + Jtemp{jj};
    end
end
end