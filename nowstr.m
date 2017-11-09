function s = nowstr
% NOWSTR Create a string for the current time
%   S = NOWSTR constructs a string of the format yyyymmdd-HHMM~ where - and ~
%   are special characters denoting the date and time respectively.  Default 
%   is 'D' for - and 'H' for ~.
%   (no arguments accepted yet.  so it's always default.)
% 
% theethan, 2015

% Might want to use some arguments for customisation?
% --some other time.

n = now; % obsessively ensure that the date string 

s = sprintf('%sd%sh',datestr(n,'yyyymmdd'),datestr(n,'HHMM'));

end
