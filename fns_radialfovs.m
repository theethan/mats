function fns_radialfovs(varargin)
% Toggles inclusion of the non-cartesian phantom acquisition simulator code 
% directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


ethanpath = '/home/ethan/';
radialfovspath = [ethanpath 'Documents/MATLAB/peder/radial_fovs'];
shapespath = [ethanpath 'Documents/MATLAB/peder/radial_fovs/shape_fcns'];

searchpathincluder( radialfovspath, varargin{:} );
searchpathincluder( shapespath, varargin{:} );

end
