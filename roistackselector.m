function [x,y,z,m] = roistackselector(im,varargin)
% ROISTACKSELECTOR Run a stack of images through ROISELECTOR
%   [XS,YS,ZS,MSK] = ROISTACKSELECTOR(IM) returns a list of x, y and z coordinates
%   corresponding to the locations of the image clicked by the user.
%   
% theethan, 2014

N = 213; % starting allocation of clicks
i = 0; % number of clicks made
p = false; % precedent mask specified (or not)

[sy,sx,sz,~] = size(im); xr=[1 sx]; yr=[1 sy]; zr=[1 sz]; % spatial scaling
m = false(sy,sx,sz);

% Parse inputs
if nargin>1 && ~isempty(varargin{1}),
    if size(varargin{1},3)==sz, m = varargin{1}; p = true;
    else m(:,:,1) = varargin{1}; end
end
if nargin>2 && ~isempty(varargin{2}), xr = varargin{2}; yr=xr; zr=xr; end
if nargin>3 && ~isempty(varargin{3}), yr = varargin{3}; end
if nargin>4 && ~isempty(varargin{4}), zr = varargin{4}; end

% Error checks
% --

% Preparations
x = zeros(1,N); y = zeros(1,N); z = zeros(1,N); % allocate

% Step through slices
fig=figure;
for j=1:sz
    % Use the preceding slice as a precedent for the mask
    if (j>1 && ~p), m(:,:,j) = m(:,:,j-1); end
    
    % Run roiselector for this slice
    [xj,yj,mj] = roiselector(squeeze(im(:,:,j,:)),m(:,:,j),[],[],fig);
    ij = length(xj); if ij==0, continue; end;
    
    % Catalogue the selections
    i = i+ij;
    if i>N, % expand if necessary
        x = [x zeros(1,N)]; y = [y zeros(1,N)]; z = [z zeros(1,N)];
        N = 2*N;
    end
    x((i-ij+1):i) = xj; y((i-ij+1):i) = yj; z((i-ij+1):i) = j;
    m(:,:,j) = mj;
end; clear s;
close(fig);

x = x(1:i); y = y(1:i); z = z(1:i);
x = (x-1)/(sx-1) * diff(xr) + xr(1);
y = (y-1)/(sy-1) * diff(yr) + yr(1);
z = (z-1)/(sz-1) * diff(zr) + zr(1);