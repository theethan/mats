function th = titlefig(titlestring,varargin)
% TITLEFIG Make a title annotation for a figure
%   TH = TITLEFIG(STR) adds an annotation to the current figure with string
%   STR.
%
%   TH = TITLEFIG(STR,POS) adds the annotation at location POS, interpreted
%   in normalised figure units.  POS specifies the middle-top of the string
%   placement (i.e. it is the intersection of 'T').
% theethan, 2015

% Defaults
pos = [0.5 1]; % x y

% Parse
if nargin>1 && ~isempty(varargin{1}), pos = varargin{1}; end

% Make the annotation
th=annotation('textbox',[-0.5+pos(1) 0+pos(2) 1 0]);

% Could include some input options
set(th,'EdgeColor','none');
set(th,'FontSize',get(0,'DefaultAxesFontSize'),'FontName',get(0,'DefaultAxesFontName'));
set(th,'HorizontalAlign','center','VerticalAlign','top');

% Fill in the string
set(th,'String',titlestring);


end