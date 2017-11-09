function fns_phantomsim(varargin)
% Toggles inclusion of the non-cartesian phantom acquisition simulator code 
% directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014

ethanpath = '/home/ethan/';
phantomsimpath = [ethanpath 'Documents/MATLAB/okai'];
% waveletfnspath = [ethanpath 'Documents/MATLAB/wavelets'];

searchpathincluder( phantomsimpath, varargin{:} );

end
