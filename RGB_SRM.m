function colour = RGB_SRM( n )
% RGB_SRM Returns the rgb vector for SRM colours.
%    C = RGB_SRM( N ) gives the Nth SRM (Standard Reference Method) value.
% theethan, 2015

n = mod(n(:)-1,7)+1;

colour = zeros(length(n),3);

for i=1:length(n), colour(i,:) = colourpicker(n(i)); end; clear i; % could really improve this

end

function colourpick = colourpicker( o )

switch o % select the right one
    case 1, colourpick = [254 231 153];
    case 2, colourpick = RGB_PLOTCLR2;
    case 3, colourpick = RGB_PLOTCLR3;
    case 4, colourpick = RGB_PLOTCLR4;
    case 5, colourpick = RGB_PLOTCLR5;
    case 6, colourpick = RGB_PLOTCLR6;
    case 7, colourpick = RGB_PLOTCLR7;
end

colourpick = colourpick / 255; % scale down

end
