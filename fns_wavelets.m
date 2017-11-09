function fns_wavelets(varargin)
% Toggles inclusion of the wavelet functions directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014

ethanpath = '/home/ethan/';
waveletfnspath = [ethanpath 'Documents/MATLAB/wavelets'];

searchpathincluder( waveletfnspath, varargin{:} );

end
