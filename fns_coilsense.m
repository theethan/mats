function fns_coilsense(varargin)
% Toggles inclusion of adam's coils code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


ethanpath = '/home/ethan/';
coilsensepath = [ethanpath 'Documents/mrsrl/projects/coilsensitivities'];

searchpathincluder( coilsensepath, varargin{:} );

end
