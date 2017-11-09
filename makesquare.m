function ms = makesquare(mr,varargin)
% MAKESQUARE Sinc-interpolate to make a rectangular image square
%   --only deals with dims. 1 & 2
%   --uses (i)fft2c
% theethan, 2015

% Preparatory values
szr = size(mr); szr = szr(1:2);

% Defaults
szs = max(szr);

% Parse
if nargin>1 && ~isempty(varargin{1}), szs = varargin{1}; end

difsz = (szs-szr)/2;
pszpre = max(0,ceil(difsz));
pszpos = max(0,floor(difsz));

fs = padarray(padarray(fft2c(mr),pszpre,0,'pre'),pszpos,0,'post');

ms = ifft2c(fs.*ww);

% nevermind...

end