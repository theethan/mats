function fns_ee469b(varargin)
% Toggles inclusion of the rad228 matlab code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


ethanpath = '/home/ethan/'; % UNIX/LINUX
% ethanpath = 'Z:/'; % WINDOWS
ee469bpath_code = [ethanpath 'Documents/class/ee469b/codes/'];
ee469bpath_data = [ethanpath 'Documents/class/ee469b/data/'];
ee469bpath_asgn = [ethanpath 'Documents/class/ee469b/assignments/'];

searchpathincluder( ee469bpath_code, varargin{:} );
searchpathincluder( ee469bpath_data, varargin{:} );
for i=1:15, q = sprintf('%s%d/code',ee469bpath_asgn,i);
    try [~] = ls(q); catch, continue; end; % just check if directory exists
%     fprintf('searchpathincluder( %s, ',q); fprintf('%s ',varargin{:}); fprintf(');\n'); % <-- DEBUG
    searchpathincluder( q, varargin{:} ); % add it if so.
end; clear q;

end
