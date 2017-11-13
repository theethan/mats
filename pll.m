function zll = pll( zparallels )
% theethan, 2014

    zll = 1/(sum( zparallels(:).^(-1) ));

end

% function zll = pll( varargin )
% 
%     zll = 1/(sum( varargin(:).^(-1) ));
% 
% end
