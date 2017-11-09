function fns_brunoluong(varargin)
% Toggles inclusion of the BL matlab codes directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

bl_code = [ethanpath 'Documents/MATLAB/brunoluong/'];

searchpathincluder( bl_code, varargin{:} );

end
