function fns_ee369c(varargin)
% Toggles inclusion of the ee369c matlab code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2015

ethanpath = '/home/ethan/';
% ethanpath = 'Z:/'; % WINDOWS
ee369cpath_code = [ethanpath 'Documents/class/ee369c/codes/'];
ee369cpath_data = [ethanpath 'Documents/class/ee369c/data/'];
ee369cpath_asgn = [ethanpath 'Documents/class/ee369c/assignments/'];

searchpathincluder( ee369cpath_code, varargin{:} );
searchpathincluder( ee369cpath_data, varargin{:} );
for i=1:15, q = sprintf('%s%d/code',ee369cpath_asgn,i);
    try [~] = ls(q); catch, continue; end; % just check if directory exists
    searchpathincluder( q, varargin{:} ); % add it if so.
end; clear q;

end
