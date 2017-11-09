function map = cmaplines2014b(n)
%CMAPLINES2014B  Color map with the line colors used for R2014b(+?).
%   CMAPLINES2014B(M) returns an M-by-3 matrix containing a the default 
%   "ColorOrder" colormap used in R2014b. LINES, by itself, is the same 
%   length as the current colormap.
%
%   For example, to set the colormap of the current figure:
%
%       colormap(lines)
%
%   See also HSV, GRAY, PINK, COOL, BONE, COPPER, FLAG, 
%   COLORMAP, RGBPLOT.

%   Copyright 1984-2002 The MathWorks, Inc. 

% (copied by?) theethan, 2016


if nargin<1, n = 1:size(get(gcf,'Colormap'),1); end

%c = get(0,'defaultAxesColorOrder');
c = [     0    0.4470    0.7410 ; ...
     0.8500    0.3250    0.0980 ; ...
     0.9290    0.6940    0.1250 ; ...
     0.4940    0.1840    0.5560 ; ...
     0.4660    0.6740    0.1880 ; ...
     0.3010    0.7450    0.9330 ; ...
     0.6350    0.0780    0.1840];

map = c(rem(n-1,size(c,1))+1,:);


end
