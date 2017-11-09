function colour = RGB_PLOTCLRN( n )
%RGB_PLOTCLRN Returns the rgb vector for the Nth colour used by plot.
% theethan, 2014

% n = mod(n(1)-1,7)+1;
% 
% switch n
%     case 1, colour = RGB_PLOTCLR1;
%     case 2, colour = RGB_PLOTCLR2;
%     case 3, colour = RGB_PLOTCLR3;
%     case 4, colour = RGB_PLOTCLR4;
%     case 5, colour = RGB_PLOTCLR5;
%     case 6, colour = RGB_PLOTCLR6;
%     case 7, colour = RGB_PLOTCLR7;
% end

n = mod(n(:)-1,7)+1;

colour = zeros(length(n),3);

for i=1:length(n), colour(i,:) = colourpicker(n(i)); end; clear i;

end

function colourpick = colourpicker( o )

switch o
    case 1, colourpick = RGB_PLOTCLR1;
    case 2, colourpick = RGB_PLOTCLR2;
    case 3, colourpick = RGB_PLOTCLR3;
    case 4, colourpick = RGB_PLOTCLR4;
    case 5, colourpick = RGB_PLOTCLR5;
    case 6, colourpick = RGB_PLOTCLR6;
    case 7, colourpick = RGB_PLOTCLR7;
end

end
