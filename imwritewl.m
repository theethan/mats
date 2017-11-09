function [] = imwritewl( imo, ww, fname )
% function imwritewl( imo, ww, fname )
% theethan, 2014

imo(imo>ww(2))=ww(2); imo(imo<ww(1))=ww(1); imo=(imo-ww(1))/(ww(2)-ww(1));
imwrite( imo, fname );

end
