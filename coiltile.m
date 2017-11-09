function mt = coiltile(m,varargin)
% COILTILE Tile coil dimension for a volume stack of images
% theethan, 2015

% Defaults
dc = 4; % coil dimension
nt = 1; % tiling size (form size(m,dc)/nt columns and nt rows)

% Parse inputs
if nargin>1 && ~isempty(varargin{1}), dc = varargin{1}; end
if nargin>2 && ~isempty(varargin{2}), nt = varargin{2}; end

% Prepare
nc = size(m,dc); nd = ndims(m); sz = size(m); % shortcuts
if rem(nc,nt)>0, nt = 1; end % default tile size to 1 if not divisible

m = reshape( m , [sz(1:dc) 1 sz(dc+1:nd)] ); % add a placeholder dim.
m = permute( m , [1:dc-1 dc+1:nd+1 dc] ); % move coils to last dim.

sz = size(m); % new size

r1 = [sz(1:nd) nt nc/nt]; % reshape size 1
p = [1 nd+1 2 nd+2 3:nd]; % permutations
r2 = [sz(1:2).*[nt nc/nt] sz(3:nd)]; % reshape size 2

mt = reshape( permute( reshape( m , r1 ) , p ) , r2 );

end
