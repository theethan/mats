function fns_rad228(varargin)
% Toggles inclusion of the rad228 matlab code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2015


fprintf('*** FOR UP-TO-DATE P-FILE-READING FUNCTIONS USE FNS_GE ***\n');


ethanpath = '/home/ethan/';
% ethanpath = 'Z:/'; % WINDOWS
rad228path = [ethanpath 'Documents/class/rad228/code/matlab'];

searchpathincluder( rad228path, varargin{:} );

end
