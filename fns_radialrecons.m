function fns_radialrecons(varargin)
% Toggles inclusion of matlab radial recons. directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2016


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

radrec_code = [ethanpath 'Documents/mrsrl/projects/radial/recons/'];

searchpathincluder( radrec_code, varargin{:} );

end
