function Jmanual = phaseShiftGenerator(L,elevation,azimuth)
%% PHASESHIFTGENERATOR returns a phase shift generator operator 
%           
%   This function has three required input arguments:
%	L: lenght of the spin chain.
%	elevation: L x 1 vector whose l-th entry is the elevation of the
%   Bloch vector on the l-th site.
%   azimuth: L x 1 vector, as above.
%
%   Jmanual = phaseShiftJenerator(L, elevation, azimuth) returns the linear
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
%	package: QFI Toolbox 
%	last updated: February 26, 2019

%%	Building blocks definitions
    dim = 2^L;
    nBlochVec = length(elevation)/L;
    sigma_x = sparse([0 1 ; 1 0]);
    sigma_y = sparse([0 -1i ; 1i 0]);
    sigma_z = sparse([1 0 ; 0 -1]);
%%	Memory allocation
    StotX = cell(L,1);
    StotY = cell(L,1);
    StotZ = cell(L,1);
    Jmanual = cell(nBlochVec,1);
    J_bench_temp = cell(L,1);
%%	Bloch sphere vectors
	radius = 1;
	[x,y,z] = sph2cart(azimuth,elevation,radius);
	blochConfig = mat2cell([x,y,z],L*ones(1,nBlochVec));
%% Spin operators
	for k = 1:L
        StotX{k} = kron(kron(speye(2^(k-1)),sigma_x),speye(2^(L-k)));
        StotY{k} = kron(kron(speye(2^(k-1)),sigma_y),speye(2^(L-k)));
        StotZ{k} = kron(kron(speye(2^(k-1)),sigma_z),speye(2^(L-k)));
	end
%%	Construction of the operator J
for k = 1:nBlochVec
    Jmanual{k} = sparse(dim,dim);
    for jj = 1:L
        J_bench_temp{jj} = 1/2*(blochConfig{k}(jj,1)*StotX{jj} + blochConfig{k}(jj,2)*StotY{jj} + blochConfig{k}(jj,3)*StotZ{jj});
        Jmanual{k} = Jmanual{k} + J_bench_temp{jj};
    end
end
end