function out = type2byte(in)
% TYPE2BYTE Convert a string description of type to number of bytes
%   + O = TYPE2BYTE(I) converts the cell array of string descriptors for
%     numerical types (e.g., {'double','uint8'}) I to an array O containing
%     their standard byte sizes.
% Minimally modified from
%   stackoverflow.com/questions/16104423/size-of-a-numeric-class
% theethan, 2017

% Hard-coded definitions
numtypes = { 'double'; 'single'; 'int8'; 'int16'; 'int32'; ...
             'int64'; 'uint8'; 'uint16'; 'uint32'; 'uint64' };
numbytes = [ NaN; 8; 4; 1; 2; 4; 8; 1; 2; 4; 8 ];

% Identify the numerical types
[~,loc] = ismember(in(:),numtypes);

% Translate to sizes
out = zeros(size(in));
out(:) = numbytes(loc+1);

end
