function [x,y,m] = roiselector(im,varargin)
% ROISELECTOR Display an image and select a region of interest by clicking
%   [X,Y,M] = ROISELECTOR(IM) returns a list of x and y coordinates
%   corresponding to the locations of the image clicked by the user.
%   
% theethan, 2014

N = 30; % starting allocation of clicks
i = 0; % number of clicks made

[sy,sx,~] = size(im); xr=[1 sx]; yr=[1 sy]; % spatial scaling
nc = size(im,3); % colour channels
m = false(sy,sx); % mask
fig = []; fh = [];

% Parse inputs
if nargin>1 && ~isempty(varargin{1}), m = varargin{1}; end
if nargin>2 && ~isempty(varargin{2}), xr = varargin{2}; yr=xr; end
if nargin>3 && ~isempty(varargin{3}), yr = varargin{3}; end
if nargin>4 && ~isempty(varargin{4}), fh = varargin{4}; end

% Error checks
if any(imag(im(:))),
    figure;
    imshow(angle(im),[-pi pi]);
    h=annotation('textbox',[0 0 1 1],'String','COMPLEX IMAGES UNALLOWED.');
    set(h,'Color','r','EdgeColor','none');
    set(h,'HorizontalAlign','center','VerticalAlign','middle');
    x=[]; y=[]; m=[]; return;
end

% Preparations
if nc==1 % grayscale image (presume RGB already otherwise)
    im = bsxfun(@times,double(im),ones(1,1,3));
    im = im-min(im(:)); im = im/max(im(:));
end
ims = im; ims(:,:,2:3) = bsxfun(@times,im(:,:,2:3),~m); % display copy

if isempty(fh), fig=figure; else figure(fh); end
x = zeros(1,N); y = zeros(1,N); % allocate
% imshow( im .* ((msk+2)/2), ww ); axch = get(gca,'Children');
% imshow( im .* (1-msk), ww ); axch = get(gca,'Children');
axch = get(gca,'Children');
if isempty(axch), imshow( ims ); axch = get(gca,'Children');
else set(axch,'CData',ims); end
title('Select a point to add or remove from ROI; press ''ENTER'' to exit');
while true, i=i+1;
    if i>N, x = [x zeros(1,N)]; y = [y zeros(1,N)]; N = 2*N; end
    
    % Take an input
    [xi,yi] = ginput(1);
    
    % Process the input
    if isempty(xi)||isempty(yi), i=i-1; break; end
    x(i) = round(xi); y(i) = round(yi); % identify the pixel
    if (x(i)<1 || x(i)>sx || y(i)<1 || y(i)>sy), i = i-1; continue; end
    m(y(i),x(i)) = ~m(y(i),x(i)); % toggle the pixel
    
    % Update display
%     set(axch,'CData', im .* ((msk+2)/2));
%     set(axch,'CData', im .* (1-msk));
    ims(:,:,2:3) = bsxfun(@times,im(:,:,2:3),~m); set(axch,'CData',ims);
end
title('ROI selected'); pause;
if isempty(fh), close(fig); end

x = x(1:i); y = y(1:i);
x = (x-1)/(sx-1) * diff(xr) + xr(1); y = (y-1)/(sy-1) * diff(yr) + yr(1);
%---might want to just return unique pairs of x & y

end