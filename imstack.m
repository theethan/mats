function [ims, alp] = imstack( im, varargin )
%IMSTACK Make a composite image by 'stacking' frames of an image
%   IMS = IMSTACK( IM ), IM is M x N x F and F is number of frames.
%   
%   IMS = IMSTACK( IM, VF ) uses a 2-vector to specify the fraction of
%   pixels in stacked images that are visible (after a border is added).
%   I.e., (1-VF(1))*size(IM,1) pixels from dim. 1 of each frame are covered
%   by the next frame.  Obviously elements of VF must be between 0 and 1!
%   Default is [0.15 0.1].
%   
%   IMS = IMSTACK( IM, VF, B ) adds a border of B(1) pixels to each side of
%   each frame.  If B is length-2, then B(2) specifies amplitude
%   ('brightness') of the border in fraction of maximum image amplitude.
%   Default is [2 0.5].
%
%   IMS = IMSTACK( IM, VF, B, ORDER ) uses the string or vector ORDER to
%   specify the order of frame-stacking: 'forward' is frame 1 on the
%   bottom, 'backward' is frame F on the bottom, and a vector of indices is
%   frame number ORDER(1) on the bottom and ORDER(F) on the top.
%   Default is 'forward'.
%
% --It'd be nice to add transparencies instead of white background.
%   -- This has been added:
%   [ IMS, ALP ] = IMSTACK( IM, etc. ) gives a transparency mask for .png.
%
% theethan, 2011

% Handy
[n1 n2 n3] = size(im);


% Defaults

ulf = [0.15 0.1]; % 'underlap'--number of visible pixels--fraction
forder = 0:n3-1; % order of frames
bdrsize = 2; % border pixels applied to each coil image
bdrampl = 0.5; % border amplitude


% Interpret arguments
if( nargin >= 2 )
    ulf = varargin{1}; ulf = ulf(1:2); ulf = min( max( ulf, 0 ), 1 );
end
if( nargin >= 3 )
    b = varargin{2}; bdrsize = b(1);
    if( length(b)>1 ), bdrampl = min( max( b(2), 0 ), 1 ); end
    clear b;
end
if( nargin >= 4 )
    if( ~ischar(varargin{3}) )
        varargin{3} = min( max( varargin{3}, 1 ), n3 ) - 1; % safety
        forder = [ setdiff(0:n3-1,varargin{3}) varargin{3} ]; % safety
    elseif( strcmp(varargin{3},'backward') )
        forder = (n3-1):-1:0;
    end
end;
if( nargout >= 2 ), TRANSPARENCY = true; else TRANSPARENCY = false; end

% Stack

im = padarray(im,[bdrsize bdrsize],bdrampl*max(abs(im(:))));

n1 = n1 + bdrsize*2; n2 = n2 + bdrsize*2;

ul = round(ulf.*[n1 n2]); % underlap

ims = max(abs(im(:))) * ones( n1+ul(1)*(n3-1), n2+ul(2)*(n3-1) );
alp = zeros(size(ims));

for f = forder
    ims((1:n1)+f*ul(1), (1:n2)+f*ul(2)) = im(:,:,f+1);
    alp((1:n1)+f*ul(1), (1:n2)+f*ul(2)) = 1;
end

end