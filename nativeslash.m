function s = nativeslash( p )
% NATIVESLASH Harmonise slashes to file system native representation
% 
%   S = NATIVESLASH( P ) takes string representation of a file path
%   containing forward- and/or back-slashes and replaces all with the
%   file system's preferred representation for directory delimiters.
%
% theethan, 2018

if strncmpi(computer,'glnx',4), pat = '\'; rep = '/'; % linux: \ -> /
elseif strncmpi(computer,'pcwin',5), pat = '/'; rep = '\'; % win: / -> \
else, fprintf('***Unknown filesystem; doing nothing.\n'); s = p; return;
end

s = strrep(p,pat,rep);

end