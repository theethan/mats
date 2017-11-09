function [] = imwriteclr( imo, ww, cmap, fname )
% function imwriteclr( imo, ww [opt.], cmap [opt.], fname )
% theethan, 2014

NDEFAULT = 64;

if any(imag(imo(:)))
    if any(real(imo(:)))
        imo=abs(imo);
        fprintf('*** complex image converted to magnitude\n');
    else
        imo=imag(imo);
    end
end

if isempty(ww), ww = [min(imo(:)) max(imo(:))]; end

% Figure out what form of colormap was sent
if isa(cmap,'function_handle'), cmap = cmap(NDEFAULT); % f'n handle
elseif size(cmap,1)==3 && size(cmap,2)~=3, cmap = cmap'; % transposed
elseif size(cmap,2)~=3, cmap = jet(NDEFAULT); % none or nonsense
end

% Rescale
imo(imo>ww(2))=ww(2); imo(imo<ww(1))=ww(1); imo=(imo-ww(1))/(ww(2)-ww(1));

% Index into the colormap
[m,n,s,~] = size(imo);
imo = reshape(cmap(max(ceil(imo*size(cmap,1)),1),:),m,n,3,s);

% Write image
% if s==1, imwrite( imo, fname );
% else for i=1:s, imwrite( imo, sprintf('%s_%1d',
% --- on second thought, too complicated to deal with file format suffix.
imwrite( imo, fname );

end
