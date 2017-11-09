function fh = waitfigopen(varargin)
% WAITFIGOPEN Open a 'waitfig' that can wait for a keypress
%   FH = WAITFIGOPEN() opens a 'waitfig' that can be made to wait for a 
%   keypress, and it returns the figure handle FH to be used with
%   WAITFIGWAIT().
% theethan, 2014

%-- maybe do something for varargin here

fh = figure('KeyPressFcn','uiresume;');
% set(fh,'Visible','off'); set(fh,'Visible','on'); % hack

end