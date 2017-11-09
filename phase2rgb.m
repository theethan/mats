function c = phase2rgb(a,varargin)
% PHASE2RGB Convert phase to RGB
%    C = PHASE2RGB(A) converts the phase of elements in A to RGB (parula)
%    and creates C with image magnitude proportional to abs(A).  The RGB 
%    dimension is appended to the dimensions of A (e.g., for A with size 
%    MxNxOxP, C has size MxNxOxPx3).
%    
%    C = PHASE2RGB(A,CM) uses the color map CM
%
% theethan, 2015

% Defaults
cm = parula(512);

% Parse
if nargin>1 && ~isempty(varargin{1}), cm = varargin{1}; end

% Prepare
nc = size(cm,1); % number of RGB indices
b = abs(a); b = b/max(b(:)); % normalised magnitude
c = zeros([size(a) 3]); % phase-coloured images

% Scale phase into indices
i = floor( (angle(a)+pi)/2/pi * nc ) + 1;
i = min(i,nc); % in case of exactly pi phase

% Index into colour map
c = reshape(cm(i(:),:),size(c));

% Scale by abs
c = bsxfun(@times,b,c);

end
