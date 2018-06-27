function axistight(xyz)
% AXISTIGHT Make the axis tight in only one chosen dimension
% 
%   AXISTIGHT( XYZ ) takes a character XYZ {allowed: 'x', 'y' or 'z'} and
%   makes the current axes (as returned by GCA) have 'tight' limits.  This
%   differs from calling AXIS TIGHT in that it only tightens one axis.  If
%   no axis is specified, this function defaults to AXIS TIGHT.
% 
% theethan, 2018

if ~exist('xyz','var') || isempty(xyz)
    axis tight; return; % not specified, make all tight
end
xyz = lower(xyz(1)); % only first character

% error check
if ~ischar(xyz) || isempty(regexp(xyz,'[xyz]','once'))
    fprintf('Invalid axis specified! (''x'', ''y'', or ''z'')\n');
end

% get series from plot (axes object)
s = get(gca,'Children');

% get series data for chosen axis
if strcmp(xyz,'x')
    l = get(s,'XData');
elseif strcmp(xyz,'y')
    l = get(s,'YData');
elseif strcmp(xyz,'z')
    l = get(s,'ZData');
end

% in case only one line
if ~iscell(l), l = {l}; end

% trim empty series {needed?}
l = l(~cellfun(@isempty,l));

% corner case?
if isempty(l), fprintf('Warning: no data found in axes!\n'); return; end

% find limits
axlims = [min(cellfun(@min,l)) max(cellfun(@max,l))];

if strcmp(xyz,'x')
    xlim(axlims);
elseif strcmp(xyz,'y')
    ylim(axlims);
elseif strcmp(xyz,'z')
    zlim(axlims);
end

end