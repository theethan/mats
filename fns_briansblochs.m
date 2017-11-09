function fns_briansblochs(varargin)
% Toggles inclusion of the bloch matlab codes directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

bloch_code = [ethanpath 'Documents/MATLAB/briansblochs/'];

searchpathincluder( bloch_code, varargin{:} );

end
