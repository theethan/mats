function imcc = cc(im,varargin)
% CC Combine coil images
%   IMCC = CC(IM) uses square-root of sum-of-squares combination to combine
%   coile images.
%
%   Coil dimension is the fourth dimension (i.e. [NX,NY,NZ,NC,~]=SIZE(IM)).
%
%   IMCC = CC(IM,D) treats dimension D as the coil dimension.
% 
% theethan, 2014

d = 4;

if nargin>1 && ~isempty(varargin{1}), d = varargin{1}; end

imcc = sqrt(sum(abs(im).^2,d));

end