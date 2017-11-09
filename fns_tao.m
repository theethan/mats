function fns_tao(varargin)
% Toggles inclusion of the bloch matlab codes directory in the search path.
% You can say 'on' and 'off' as well to (en)force inclusion or exclusion.
% theethan, 2016


if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end

tao_code_base = [ethanpath 'Documents/MATLAB/tao/'];

searchpathincluder( tao_code_base, varargin{:} );

% add all subdirectories too
add_subdirs( tao_code_base, varargin{:} );


end


function add_subdirs( base, varargin )
% ADD_SUBDIRS Recurseively addpath on the subdirectories

d = dir(base);
for i=1:length(d)
    if strcmp(d(i).name,'.')||strcmp(d(i).name,'..'), continue; % don't add
    elseif d(i).isdir
        searchpathincluder( [base d(i).name], varargin{:} ); % add
        add_subdirs( [base d(i).name '/'], varargin{:} ); % recurse
    end
end; clear i;

end
