function fns_regiongrow(varargin)
% Toggles inclusion of the bloch matlab codes directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2016


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

rg_code = [ethanpath 'Documents/MATLAB/regiongrow'];

searchpathincluder( rg_code, varargin{:} );

end
