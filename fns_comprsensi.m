function fns_comprsensi(varargin)
% Toggles inclusion of the CS code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014

ethanpath = '/home/ethan/';
comprsensipath = [ethanpath 'Documents/MATLAB/compressedsensing'];
waveletfnspath = [ethanpath 'Documents/MATLAB/wavelets'];

searchpathincluder( comprsensipath, varargin{:} );
searchpathincluder( waveletfnspath, varargin{:} );

end
