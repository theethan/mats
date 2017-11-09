function searchpathincluder( pathtoinclude, varargin )
% SEARCHPATHINCLUDER Toggles inclusion of the given path in search path.
%   You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, ca. 2012

narginchk(1,2);
if pathtoinclude(end)=='/', pathtoinclude=pathtoinclude(1:end-1); end

if isempty(varargin) % toggle
%     pathtoinclude % DEBUG
%     strfind( path, pathtoinclude ) % DEBUG
    if isempty( strfind( path, pathtoinclude ) )
        addpath( pathtoinclude );
    else
        rmpath( pathtoinclude );
    end
elseif(strcmp(varargin{1}, 'on')) % force on
    addpath( pathtoinclude );
elseif(strcmp(varargin{1}, 'off')) % force off
    if ~isempty( strfind( path, pathtoinclude ) ) % avoid any warning
        rmpath( pathtoinclude );
    end
else
    error('MATLAB:searchpathincluder:UnknownOption', ...
          'Unknown command option.');
end



end