function fns_gridding(varargin)
% Toggles inclusion of matlab gridding codes directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2015


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

gridding_code = [ethanpath 'Documents/MATLAB/gridding/'];

searchpathincluder( gridding_code, varargin{:} );

end
