function [] = imwritesc( varargin )
%IMWRITESC Level, scale and write image to graphics file
%   IMWRITESC(ARGS) levels and scales the image for output by IMWRITE.  All
%   arguments are the same as IMWRITE.
% theethan, 2014

im = varargin{1};

level = min(im(:));  im = im - level;
scale = max(im(:));  if( scale ~= 0); im = im / scale; end

varargin{1} = im;

imwrite( varargin{:} );

end
