function fns_yalmip(varargin)
% Toggles inclusion of the yalmip functions directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014

basepath = '/home/ethan/Documents/MATLAB/logi/yalmip';

yalmipfnspaths = cell(1,11);
yalmipfnspaths{1} = [basepath ''];
yalmipfnspaths{2} = [basepath '/extras'];
yalmipfnspaths{3} = [basepath '/demos'];
yalmipfnspaths{4} = [basepath '/solvers'];
yalmipfnspaths{5} = [basepath '/modules'];
yalmipfnspaths{6} = [basepath '/modules/parametric'];
yalmipfnspaths{7} = [basepath '/modules/moment'];
yalmipfnspaths{8} = [basepath '/modules/global'];
yalmipfnspaths{9} = [basepath '/modules/robust'];
yalmipfnspaths{10} = [basepath '/modules/sos'];
yalmipfnspaths{11} = [basepath '/operators'];

for i=1:length(yalmipfnspaths)
    searchpathincluder( yalmipfnspaths{i}, varargin{:} );
end; clear i;

end

