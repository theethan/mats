function fns_logi(varargin)
% Toggles inclusion of Logi's Matlab routines directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


basepath = '/home/ethan/Documents/MATLAB/logi';

logifnspaths = cell(1,2);
logifnspaths{1} = [basepath ''];
logifnspaths{2} = [basepath '/T2FilterDesign'];

for i=1:length(logifnspaths)
    searchpathincluder( logifnspaths{i}, varargin{:} );
end; clear i;

end
