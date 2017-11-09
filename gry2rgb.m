function [rgb,varargout] = gry2rgb(gry,varargin)
% GRY2RGB Convert a grayscale image to RGB colour according to intensity
%
%   RGB = GRY2RGB(GRY) indexes a default colour map using the normalised 
%   intensity of GRY to create RGB.
%   
%   RGB = GRY2RGB(GRY,CM) uses the Nx3 (any N) colour map given in CM.
%
%   RGB = GRY2RGB(GRY,CM,WL) applies with intensity window WL to GRY before
%   indexing (i.e. GRY is capped/floored to the range of WL).
%
% theethan, 2016


% Defaults
nc = 512; % number of colours in map
cm = mean(cat(3, parula(nc) , copper(nc) ),3); % colourmap
%cm = jet(nc);
cmtol = 1e-10;
wl = spread(gry(:));

% Parse
if nargin>1 && ~isempty(varargin{1}), cm=varargin{1}; nc=size(cm,1); end
if nargin>2 && ~isempty(varargin{2}), wl=varargin{2}; end
if nargin>3 && ~isempty(varargin{3}), cmtol=varargin{3}; end

% Error checks
%--whatevs.

% Condition
gry = (gry-wl(1))/diff(wl); % scale to window/level
gry(gry>1) = 1; gry(gry<(0+cmtol)) = cmtol; % threshold to (0,1]

% Convert
rgb = reshape( cm(ceil(nc*gry),:) , [size(gry) 3] );

% Bonus
if nargout>1
    icmbar = ceil(nc*linspace(1,cmtol,nc).')*ones(1,ceil(0.13*nc));
    cmbar = reshape( cm(icmbar,:) , nc,[],3); % colorbar
    varargout{1} = cmbar;
end


end