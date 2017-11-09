function fns_rad229(varargin)
% Toggles inclusion of the rad229 matlab code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


ethanpath = '/home/ethan/'; % UNIX/LINUX
% ethanpath = 'Z:/'; % WINDOWS
rad229path_code = [ethanpath 'Documents/class/rad229/codes/'];
rad229path_data = [ethanpath 'Documents/class/rad229/data/'];
rad229path_asgn = [ethanpath 'Documents/class/rad229/assignments/'];

searchpathincluder( rad229path_code, varargin{:} );
searchpathincluder( rad229path_data, varargin{:} );
for i=1:15, q = sprintf('%s%d',rad229path_asgn,i);
    try [~] = ls(q); catch, continue; end; % just check if directory exists
    searchpathincluder( q, varargin{:} ); % add it if so.
end; clear q;

end
