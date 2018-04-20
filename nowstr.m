function s = nowstr(varargin)
% NOWSTR Create a string for the current time
%   S = NOWSTR constructs a string of the format yyyymmdd-HHMM~ where - and ~
%   are special characters denoting the date and time respectively.  Default 
%   is 'D' for - and 'H' for ~.
%   (no arguments accepted yet.  so it's always default.)
% 
% theethan, 2015

% Might want to use some arguments for customisation?
% --some other time.
% --added now (hah.):
d = 'd'; h = 'h'; % default
if nargin>0 && ischar(varargin{1}), d = varargin{1}; end % input override
if nargin>1 && ischar(varargin{2}), h = varargin{2}; end % input override

n = now; % obsessively ensure that the date string 

s = sprintf('%s%s%s%s',datestr(n,'yyyymmdd'),d,datestr(n,'HHMM'),h);

end
