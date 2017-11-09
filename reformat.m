function imrf = reformat( im, f, r )
% REFORMAT Reformat a 3D image.
%   IMRF = REFORMAT( IM, F, R ) reformats the 3D dataset from format F to
%   format R.  Formats are specified by their first three letters (e.g.,
%   axial is 'axi').
% theethan, 2012

fr = lower([f(1:3) r(1:3)]);

if strcmp(fr(1:3), fr(4:6)), imrf = im; return; end

extradims = 4:ndims(im);

switch fr
    case 'axisag'
        imrf = permute( flipdim(flipdim(im,3),2), [3 1 2 extradims] );
    case 'axicor'
        imrf = permute( flipdim(im,3), [3 2 1 extradims] );
    case 'sagaxi'
        imrf = permute( flipdim(flipdim(im,1),3), [2 3 1 extradims] );
    case 'sagcor'
        imrf = permute( flipdim(im,3), [1 3 2 extradims] );
    case 'coraxi'
        imrf = permute( flipdim(im,1), [3 2 1 extradims] );
    case 'corsag'
        imrf = permute( flipdim(im,2), [1 3 2 extradims] );
    otherwise
        fprintf( '*** Warning: did not recognize formats %s/%s\n', f, r );
        imrf = im;
end

end