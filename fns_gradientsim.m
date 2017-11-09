function fns_gradientsim(varargin)
% Toggles inclusion of the bloch matlab codes directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2015


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

gradientsim_code = [ethanpath 'Documents/MATLAB/gradientsim/'];

searchpathincluder( gradientsim_code, varargin{:} );

end
