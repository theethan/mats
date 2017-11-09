function [data, header] = loadcsvlim( filepath, nlines )
% LOADCSVLIM Reads data in from a CSV file--limited functionality.
%    I think this is for csv files, at least.  The files tested are parsed 
%    that way by fscanf, but they seem to be binary files.
% theethan, 2010

if nargin > 1
    READLIMIT = nlines;
else
    READLIMIT = 1000;
end


fid = fopen( filepath );

% Skip channel / trace (and any other header) information
headerline = fgetl( fid );
while( headerline(1) == '"' )
    headerline = fgetl( fid );
end

header = headerline;

% % Expect 3 columns for now
% [header, count] = sscanf( headerline, '%s' );

data = []; % inefficient...
[dataline, count] = fscanf( fid, '%E,' );
failsafe = 0;
while( count > 0 && failsafe < READLIMIT)
    data = [ data dataline ];
    [dataline, count] = fscanf( fid, '%E,' );
    failsafe = failsafe+1;
end

% File close
fclose(fid); clear fid;


end