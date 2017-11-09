% 2009/05/21 new input option plane
% 2008/09/25 check if scale is empty
% 2008/09/24 copied from Peder's tiffserieswrite()
%            mod by HW to take write_idx as input

function tiffserieswrite(ims, filename, write_idx, scale, plane);
% TIFFSERIESWRITE(IMS, FILENAME, [SCALE])
%  Writes a series of TIFF files using the 3D input image
%  For use importing to Osirix (for cool 3D renderings!)
%
%  IMS - 3-D array, will write the absolute value of the image
%  FILENAME - will automatically add frame number and .tif extension
%  SCALE = [MIN, MAX] (optional) - scales images to this absolute value range before writing
%  PLANE = 1 axl, 2 sag, 3 cor - orientation of output series
%
% Peder Larson 06/26/2006

if( nargin < 4 || isempty(scale) )
  scale = [0 max(abs(ims(:)))];
end
if( nargin < 5 )
  plane = 1;
end  

imsw = (abs(ims) - scale(1))/(scale(2)-scale(1));
imsw(find(imsw < 0)) = 0;

if( plane==2 )
    imsw = permute( imsw, [1 3 2] );
elseif( plane==3 )
    imsw = permute( imsw, [2 3 1] );
end

nframes = size(imsw,3);
len_number = ceil(log10(nframes));

if( nargin<3 || isempty(write_idx) )
  write_idx = 1:nframes;
end    

for k = 1:nframes
  fkname = eval(['sprintf(''' filename '_%.' int2str(len_number) 'd.tif'', write_idx(k))']);

  if( plane>1 )
    imwrite(rot90(imsw(:,:,k)), fkname, 'tiff', 'Compression', 'none');
  else    
    imwrite(imsw(:,:,k), fkname, 'tiff', 'Compression', 'none');
  end  
end
