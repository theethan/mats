function fns_arbenc(varargin)
% Toggles inclusion of the arbenc code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


ethanpath = '/home/ethan/';
arbencpath = [ethanpath 'Documents/mrsrl/projects/arbenc/code'];

searchpathincluder( arbencpath, varargin{:} );

end
