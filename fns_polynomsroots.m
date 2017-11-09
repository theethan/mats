function fns_polynomsroots(varargin)
% Toggles inclusion of the CS code directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2014


basepath = '/home/ethan/Documents/MATLAB/polynomsroots/WebLF21';

polynomsrootsfnspaths = cell(1,9);
polynomsrootsfnspaths{1} = [basepath ''];
polynomsrootsfnspaths{2} = [basepath '/broots'];
polynomsrootsfnspaths{3} = [basepath '/lroots'];
% polynomsrootsfnspaths{4} = [basepath '/lroots/simp_fl'];
polynomsrootsfnspaths{5} = [basepath '/multroot/multroot'];
polynomsrootsfnspaths{6} = [basepath '/shared'];
polynomsrootsfnspaths{7} = [basepath '/mexFiles'];
polynomsrootsfnspaths{8} = [basepath '/Unwrap'];
polynomsrootsfnspaths{9} = [basepath '/util'];

for i=1:length(polynomsrootsfnspaths)
    if isempty(polynomsrootsfnspaths{i}), continue; end
    searchpathincluder( polynomsrootsfnspaths{i}, varargin{:} );
end; clear i;

end
