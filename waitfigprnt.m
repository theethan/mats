function success = waitfigprnt(fh,varargin)
% WAITFIGPRINT Print a figure pending a 'waitfig' keypress
%   ACCEPT = WAITFIGPRNT(FH,[FT,FN]) waits on the figure with handle FH 
%   for a keypress and optionally outputs the figure with the print
%   function.  It then closes or leaves open the figure upon receiving the
%   keypress.  If the keypress is enter the figure will be printed and
%   closed; if the keypress is escape the figure will not be printed but
%   will be closed; and if the keypress is anything else the figure will be
%   left open but not printed.  FT is the file-type to be printed [default:
%   -dpdf], and FN is the filename used [default: figure_X].
%
%   WAITFIGPRNT(...,[NC,EO]) does the same but optionally leaves the figure
%   open if true is passed as NC, and optionally passes extra options EO to
%   print.
%   
% theethan, 2014

WAITMESSAGE = ...
    'enter: print & close  |  escape: close   |   any other key: continue';

% Defaults
accept=[]; cl=true; nocl=false; % redundant?
if isnumeric(fh), fhn = fh; else, fhn = fh.Number; end % r2014b update
fn = sprintf('figure_%d',fhn); ft = '-dpdf';
success = [];
eo = {};

% Parse
if nargin>1 && ~isempty(varargin{1}), ft = varargin{1}; end
if nargin>2 && ~isempty(varargin{2}), fn = varargin{2}; end
if nargin>3 && ~isempty(varargin{3}), nocl = varargin{3}; end
if nargin>4 && ~isempty(varargin{4}), eo = varargin{4}; end

% Error check
if ~strncmpi(get(fh,'KeyPressFcn'),'uiresume',8)
    annotation('textbox',[0 0 1 1],...
                   'String',sprintf('Figure %d is not a waitfig\n',fhn),...
                   'EdgeColor','none','Color',[0.8 0 0],...
                   'FontSize',18,'HorizontalAlignment','center',...
                    'VerticalAlignment','middle');
    return; % I quit!
end
if ~iscell(eo), eo={eo}; end

% Wait
while true
    figure(fh);
    ah=annotation('textbox',[0 0 1 1],...
                  'String',WAITMESSAGE,...
                  'EdgeColor','none','Color',[0.8 0 0],...
                  'FontSize',7,'HorizontalAlignment','center',...
                  'VerticalAlignment','bottom');
    try
        uiwait; kp = get(fh,'Currentkey');
        if strcmp(kp,'escape'), accept=false; cl=true; break;
        elseif strcmp(kp,'return'), accept=true; cl=true; break;
        else, accept=[]; cl=false; break;
        end
    catch me % maybe it was closed--exit now
        if strcmp(me.identifier,'MATLAB:class:InvalidHandle'), break;
        else, dispmexception(me); end;
    end
end
try delete(ah); catch me, dispmexception(me); end
if accept
    success = false; % don't assume success
    try
        print(ft,eo{:},fn); success = true;
        ah = annotation('textbox',[0 0 1 1],...
                        'String',sprintf('wrote file: %s',fn),...
                        'EdgeColor','none','Color',[0.8 0 0],...
                        'FontSize',18,'HorizontalAlignment','center',...
                        'VerticalAlignment','middle',...
                        'Interpreter','none');
        pause(0.5); delete(ah);
    catch me
        annotation('textbox',[0 0 1 1],...
                   'String',sprintf('PRINT PROBLEM\n%s',me.message),...
                   'EdgeColor','none','Color',[0.8 0 0],...
                   'FontSize',18,'HorizontalAlignment','center',...
                    'VerticalAlignment','middle');
        fprintf('***print problem\n'); disp(me);
        cl = false;
    end    
end
if cl&&~nocl, try close(fh); catch me, dispmexception(me); end; end

end