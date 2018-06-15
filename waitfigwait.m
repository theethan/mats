function accept = waitfigwait(fh,varargin)
% WAITFIGWAIT Wait for a 'waitfig' keypress
%   ACCEPT = WAITFIGWAIT(FH) waits on the figure with handle FH for a
%   keypress and closes or leaves open the figure upon receiving the
%   keypress.  If the keypress is enter or escape, acceptance or not will 
%   be returned.
%
%   ACCEPT = WAITFIGWAIT(FH,NC) does the same but optionally leaves the
%   figure open if true is passed as NC.
% theethan, 2014

WAITMESSAGE = 'enter/escape: close   |   any other key: continue';

% Defaults
accept=[]; cl=true; nocl=false; % redundant?
if isnumeric(fh), fhn = fh; else fhn = fh.Number; end % r2014b update

% Error check
%if ~strncmpi(get(fh,'KeyPressFcn'),'uiresume',8)
%    fprintf('Figure %d is not a waitfig\n',fh); return; % I quit!
%end
if ~strncmpi(get(fh,'KeyPressFcn'),'uiresume',8)
    annotation('textbox',[0 0 1 1],...
                   'String',sprintf('Figure %d is not a waitfig\n',fhn),...
                   'EdgeColor','none','Color',[0.8 0 0],...
                   'FontSize',18,'HorizontalAlignment','center',...
                    'VerticalAlignment','middle');
    return; % I quit!
end

% Parse
if nargin>1 && ~isempty(varargin{1}), nocl = varargin{1}; end

% Wait
while true
    figure(fh);
    ah=annotation('textbox',[0 0 1 1],...
                  'String',WAITMESSAGE,...
                  'FontSize',7,'EdgeColor','none','Color',[0.8 0 0],...
                  'HorizontalAlignment','center',...
                  'VerticalAlignment','bottom');
    try
        uiwait; kp = get(fh,'Currentkey');
        if strcmp(kp,'escape'), accept=false; cl=true; break;
        elseif strcmp(kp,'return'), accept=true; cl=true; break;
        else accept=[]; cl=false; break;
%         else fprintf('key pressed: %s\n',kp); % DEBUG
        end
    catch me % maybe it was closed--exit now
        if ~strcmp(me.identifier,'MATLAB:class:InvalidHandle'), disp(me);
        end
        break;
    end
end
if cl&&~nocl, try close(fh); end % --no 'catch' (ignore errors)
else delete(ah); end

end