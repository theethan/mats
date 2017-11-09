function fns_t2slr(varargin)
% Toggles inclusion of the bloch matlab codes directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

t2slr_code = [ethanpath 'Documents/MATLAB/t2slr/'];

searchpathincluder( t2slr_code, varargin{:} );

end
