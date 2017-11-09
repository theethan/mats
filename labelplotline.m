function h = labelplotline(x,y,i,s,varargin)
% LABELPLOTLINE Add a text label to a line on a plot
%   H = LABELPLOTLINE(X,Y,I,S) adds a text object to the current axes, at 
%   the position X(I), Y(I), sets the object's rotation to match the slope
%   of Y at X(I) and sets its string to S.  The handle H is returned.
%   
%   H = LABELPLOTLINE(X,Y,I,S,A) uses the axes A.
% theethan, 2015

% Defaults
ax = gca;
di = [-1 1]; % index offsets
fu = 0; % rotation fudge ('shim')

% Parse arguments
if nargin>=5 && ~isempty(varargin{1}), ax = varargin{1}; end % axes
if nargin>=6 && ~isempty(varargin{2}), di = varargin{2}; end % idx offset
if nargin>=7 && ~isempty(varargin{3}), fu = varargin{3}; end % rot'n fudge


% Calculate rotation to match apparent slope

% Ref 1
%     lblrot = atan2(diff(ms(3,itl+[-1 1],i0,1,i)),...
%                    diff(ms(1,itl+[-1 1],i0,1,i)))*180/pi;

% Ref 2
% ngl1 = atan2(diff(abs(m1xy(1,1,1,1,j1+[-1 1])))/diff(ylim),diff(log10(t2(j1+[-1 1])))/diff(log10(xlim)));

% Ref 3
%     if (strcmp(get(cax, 'XDir'), 'reverse'))
%         XDir = -1;
%     else
%         XDir = 1;
%     end
%     if (strcmp(get(cax, 'YDir'), 'reverse'))
%         YDir = -1;
%     else
%         YDir = 1;
%     end
%
%     UN = get(cax, 'Units');
%     parent = get(cax, 'Parent');
%     if strcmp(UN, 'normalized') && strcmp(get(parent, 'Type'), 'figure')
%         UN = get(parent, 'PaperUnits');
%         set(parent, 'PaperUnits', 'points');
%         PA = get(parent, 'PaperPosition');
%         set(parent, 'PaperUnits', UN);
%         PA = PA .* get(cax, 'Position');
%     else
%         set(cax, 'Units', 'points');
%         PA = get(cax, 'Position');
%         set(cax, 'Units', UN);
%     end
%
%     Aspy = PA(4) / diff(YL);  % to get the gaps for text the correct size)
%     Aspx = PA(3)/log10(XL(2)/XL(1)); % [ethan]
% 
%                 trot = atan2((yr - yl) * YDir * Aspy, (log10(xr./xl)) * XDir * PA(3)/log10(XL(2)/XL(1))) * 180 / pi; % [ethan]

% un = get(ax, 'Units');
% parent = get(ax, 'Parent');
% if strcmp(un, 'normalized') && strcmp(get(parent, 'Type'), 'figure')
%     un = get(parent, 'PaperUnits');
%     set(parent, 'PaperUnits', 'points');
%     ap = get(parent, 'PaperPosition');
%     set(parent, 'PaperUnits', un);
%     ap = ap .* get(ax, 'Position');
% else
%     set(ax, 'Units', 'points');
%     ap = get(ax, 'Position');
%     set(ax, 'Units', un);
% end
%---too complicated.
ap = get(ax,'Position'); % axis aspect ratio (ap(3) & ap(4))

if strcmpi(get(ax,'XDir'),'reverse'), xd = -1; else xd = 1; end % direction
if strcmpi(get(ax,'YDir'),'reverse'), yd = -1; else yd = 1; end % of axes

xl = get(ax,'XLim'); yl = get(ax,'YLim'); % axis scales

% if i==1, di(1) = 0; elseif i==length(x), di(2) = 0; end % corner cases
if i+di(1)<1, di(1)=1-i; end; if i+di(2)>length(x), di(2)=length(x)-i; end

% relative delta x & y
if strcmpi(get(ax,'XScale'),'linear'), rdx = diff(x(i+di))/diff(xl);
else rdx = log10(x(i+di(2))/x(i+di(1))) / log10(xl(2)/xl(1)); end
if strcmpi(get(ax,'YScale'),'linear'), rdy = diff(y(i+di))/diff(yl);
else rdy = log10(y(i+di(2))/y(i+di(1))) / log10(yl(2)/yl(1)); end

r = atan2( yd* rdy *ap(4) , xd* rdx *ap(3) ); % rotation angle [rad]
% --- something's a little bit off; but good enough for now.

h = text(x(i),y(i),s); % make text object with the string
set(h,'Parent',ax); % put it on the right axes
set(h,'Rotation',r*180/pi+fu); % set its rotation

end