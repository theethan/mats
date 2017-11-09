function setpropstext(h,varargin)
% SETPROPSTEXT Sets properties for a text annotation
%   SETPROPSTEXT(h) with no additional arguments sets default font, size
%   and alignment properties for the text annotation with handle h.
%
%   SETPROPSTEXT(h,n,p) sets the defaults in addition to property or
%   properties with name(s) N to P.
%   
% theethan, 2014

if nargin>1 && ~isempty(varargin) % overly accomodating...
    if nargin==3 && iscell(varargin{1}), n = varargin{1}; p = varargin{2};
    elseif nargin==1, n = varargin{1}(1:2:end); p = varargin{1}(2:2:end);
    else n = varargin(1:2:end); p = varargin(2:2:end);
    end % make sure n & p wind up as cell arrays
else n = {}; p = {};
end

if numel(n)~=numel(p)
    fprintf('***WARNING: ignoring unintelligible properties list.\n');
    np = {};
else
    np = {n{:};p{:}}; % interleave the properties again
end
% varargin,n,p,np

% Property-name shortcuts
irms = [];
for i=1:2:numel(np), rmi = false;
    if strncmpi(np{i},'va',2),
        np{i} = 'VerticalAlignment';
        if strncmpi(np{i+1},'mid',3), np{i+1} = 'Middle';
        elseif strncmpi(np{i+1},'bot',3), np{i+1} = 'Bottom';
        elseif strncmpi(np{i+1},'top',3), np{i+1} = 'Top';
        else rmi = true;
        end
    elseif strncmpi(np{i},'ha',2),
        np{i} = 'HorizontalAlignment';
        if strncmpi(np{i+1},'cen',3), np{i+1} = 'Center';
        elseif strncmpi(np{i+1},'lef',3), np{i+1} = 'Left';
        elseif strncmpi(np{i+1},'rig',3), np{i+1} = 'Right';
        else rmi = true;
        end
    end
    if rmi, 
        irms = [irms i];
        fprintf('***WARNING: ignored bad property [%s/%s]\n',np{i+[0 1]});
    end
end; clear i;
for i=irms, np = np([1:i-1 i+2:end]); end; clear i;

set(h,...
    'FontName',get(0,'DefaultAxesFontName'),...
    'FontSize',get(0,'DefaultAxesFontSize'), ...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom',...
    np{:});

end