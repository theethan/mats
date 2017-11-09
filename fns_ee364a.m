function fns_ee364a(varargin)
% Toggles inclusion of the rad228 matlab code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% Bonus for 364A: 'cvx' instead of 'on' is enables cvx in addition.
% theethan, 2014


ethanpath = '/home/ethan/';
ee364apath_code = [ethanpath 'Documents/class/ee364a/codes/'];
ee364apath_data = [ethanpath 'Documents/class/ee364a/data/'];

if ~isempty(varargin) && strcmp(varargin{1},'cvx')
    fns_cvx;
    varargin{1}='on';
end

searchpathincluder( ee364apath_code, varargin{:} );
searchpathincluder( ee364apath_data, varargin{:} );

end
