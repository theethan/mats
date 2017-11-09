function fns_bart(varargin)
% Turns 'on' the installation of BART.
% theethan, 2016

% Warning about 'off'
if(strcmp(varargin{1}, 'off')) % force off
    fprintf('**warning: ''fns_bart off'' not fully implemented\n');
end

% Temporarily cd to the installation path and use the 'vars' script of BART
bartpath = '/usr/local/share/mrirecon-bart-bd2e9e7';
here = pwd;
cd(bartpath); vars; cd(here);

% Also include add-on functions/scripts
if strncmpi(computer,'glnx',4), ethanpath = '/home/ethan/'; % surely linux
else ethanpath = 'Z:/'; % presume windows
end
bartpath = [ethanpath 'Documents/MATLAB/bart/'];
searchpathincluder( bartpath, varargin{:} );

end
