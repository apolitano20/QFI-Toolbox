function x = randPdf(p, pxVec, dims)
% RANDPDF
%   Random numbers from a user defined distribution
%
% SYNTAX:
%   x = randPdf(p, pxVec, dims)
%       randPdf(p, pxVec, dims)
% 
% INPUT:
%   p   - probability density,
%   pxVec  - values for probability density,
%   dims - dimension for the output matrix.
%
% OUTPUT:
%   x   - random numbers. Run function without output for some plots.
%
% DESCRIPTION:
%   x = randPdf(p, pxVec, dims) returns the matrix of random numbers from
%   probability density distribution defined in p and pxVec. p are the density
%   (the y axis) and pxVec are the value (the x axis) of the pdf. p and pxVec
%   must be of the same length.
%   dims define the output matrix dimensions, for example dims=[100 3] define
%   the 100x3 two dimensional matrix with 300 random numbers.
%
%   REMEMBER: This is not a realy random number generator but only
%   some kind of transformation of uniformly distributed pseudorandom 
%   numbers to desired pdf!
% 
% EXAMPLE 1:
%   Generation of normal distributed random numbers. This is not typical
%   normal distribution because is limited from the left and right side,
%   i.e. 0 < pxVec < 80 .
%   
%   pxVec=0:80;
%   p=1./(10*sqrt(2*pi))*exp((-(pxVec-40).^2)./(2*10^2));
%   randPdf(p,pxVec,[10000,1])
%
%
% EXAMPLE 2:
%   Generation using user defined pdf.
%   
%   pxVec=[1 2 3 4 5 6 7 8 9];
%   p= [0 1 3 0 0 4 5 4 0];
%   randPdf(p,pxVec,[50000,1])

% package: QFIEntanglementToolbox.utils

% check the number of input
error(nargchk(3, 3, nargin))

% vectorization and normalization of the input pdf
pxVec=pxVec(:);
p=p(:)./trapz(pxVec,p(:));

% interpolation of the input pdf for better integration
% in my opinion 10000 point is sufficient...
pxInterpolated=[linspace(min(pxVec),max(pxVec),10000)]';
pInterpolated=interp1(pxVec,p,pxInterpolated,'linear');

% computing the cumulative distribution function for input pdf
cdfP = cumtrapz(pxInterpolated,pInterpolated);

% finding the parts of cdf parallel to the X axis 
nonZeroDiffIdx=[true; not(diff(cdfP)==0)];

% and cut out the parts
cdfP=cdfP(nonZeroDiffIdx);
pInterpolated=pInterpolated(nonZeroDiffIdx);
pxInterpolated=pxInterpolated(nonZeroDiffIdx);

% generating the uniform distributed random numbers
uniformDistNums=rand(dims);

% and distributing the numbers using cdf from input pdf
userDistNums=interp1(cdfP,pxInterpolated,uniformDistNums(:)','linear');

% making graphs if no output exists
if nargout==0
    subplot(3,4,[1 2 5 6])
    [nHist,xHist]=hist(userDistNums,50);
    nHist=nHist./sum(nHist)./(xHist(2)-xHist(1));
    bar(xHist,nHist)
    hold on
    plot(pxInterpolated, pInterpolated./trapz(pxInterpolated,pInterpolated),'r')
    hold off
    legend('pdf from generated numbers','input pdf')

    subplot(3,4,[3 4 7 8])
    plot(pxInterpolated, cdfP,'g')
    ylim([0 1])
    legend('cdf from input pdf')

    subplot(3,4,[9:12])
    plot(userDistNums)
    legend('generated numbers')
else
    x=reshape(userDistNums,dims);
end
