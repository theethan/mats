function [accept,i] = displaystack(ims, varargin)
% DISPLAYSTACK Display a stack of images
%   DISPLAYSTACK(ims) opens a new figure to display a series of images that
%   can be paged-through using the arrow keys and page up/down.  The escape
%   key closes the figure.  The home and end keys jump to the beginning and
%   end of the series.
%   
%   Images are stacked in the third dimension.  RGB colours are specified
%   in the fourth dimension.
% 
% theethan, 2012

nims = size(ims,3); % number of images
nchn = size(ims,4); % number of channels
% axisoptn = false;

% --- Interpret arguments ---
titles = cell(1,nims);
if nargin>1 && ~isempty(varargin{1}), titles(:) = varargin{1}(:);
else, for i = 1:nims, titles{i} = sprintf('%d/%d',i,nims); end; clear i;
end

% if nargin>2
%     ww = varargin{2};
%     ims(abs(ims)<ww(1)) = ww(1); ims(abs(ims)>ww(2)) = ww(2);
% end
% -- why is that commented-out?
% -- -- I think because it didn't do what was intended...which is this:
if nargin>2 && ~isempty(varargin{2}), ww = varargin{2};
else, ww = [-inf inf];
end

if nargin>3, axisoptn = varargin{3}; end

if nargin>4, cmap = varargin{4}; else cmap = 'gray'; end % no error check

% --- Process & prepare ---
%ims = double(ims); % just force conversion
s = round(0.05*nims); % big-step (pgup/dn) step size
if isfloat(ims) % only do this if floating pt.
    % <<<<<
%s = round(0.05*nims); % big-step (pgup/dn) step size
if nchn~=3, nchn = 1; else, nchn = 1:3; end % if ~=3 don't know what it is
if any(imag(ims(:)))
    if any(real(ims(:))),ims=abs(ims); else, ims=imag(ims); end
end
ims(ims<ww(1))=ww(1); ims(ims>ww(2))=ww(2); % ims definitely real now
% ims = permute( (ims-minel(ims))/(maxel(ims)-minel(ims)), [1 2 4 3] );
% ims = permute( ims, [1 2 4 3] );
rng = (maxel(ims)-minel(ims)); low = minel(ims);
if rng==0, rng=1; end % corner case of total iso-intensity
ims = permute( (ims-low)/rng, [1 2 4 3] ); ww = (ww-low)/rng;
    % >>>>>
else
    ww = []; % ?
    ims = permute( ims, [1 2 4 3] ); % kind of stupid, should not permute
end


% --- OK, show! ---
i = 1; % <-- start at 1
fig = figure('KeyPressFcn','uiresume;'); colormap(cmap); axis off; hold on;
while true
    figure(fig), clf; set(gca,'YDir','reverse'); axis off; hold on;
    imview(ims(:,:,nchn,i),ww); title(titles{i}); %axis off;
    if exist('axisoptn','var'), axis(axisoptn); end
    try
        uiwait; kp = get(fig,'Currentkey');
        if strcmp(kp,'leftarrow'), i = max( i-1, 1 );
        elseif strcmp(kp,'uparrow'), i = max( i-1, 1 );
        elseif strcmp(kp,'rightarrow'), i = min( i+1, nims );
        elseif strcmp(kp,'downarrow'), i = min( i+1, nims );
        elseif strcmp(kp,'home'), i = 1;
        elseif strcmp(kp,'end'), i = nims;
        elseif strcmp(kp,'pagedown'), i = min( i+s, nims );
        elseif strcmp(kp,'pageup'), i = max( i-s, 1 );
        elseif strcmp(kp,'escape'), if nargout>0, accept=false; end; break;
        elseif strcmp(kp,'return'), if nargout>0, accept=true; end; break;
%         else fprintf('key pressed: %s\n',kp); % DEBUG
        end
    catch me % maybe it was closed--exit now
        if strcmp(me.identifier,'MATLAB:class:InvalidHandle'), break;
        else disp(me); end;
    end
end
try close(fig); end % -- ignore errors
clear fig;

end