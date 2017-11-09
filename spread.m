function s = spread(x,dim)
% SPREAD Identify the minimum and maximum values.
%   s = SPREAD( X ) returns the minimum and maximum values in X.  For a
%   matrix input, S is a matrix containing the spread for each column.  For
%   N-D arrays, range operates along the first non-singleton dimension.
%   
%   SPREAD treats NaNs as missing values, and ignores them.
%   
%   Y = SPREAD( X, DIM ) operates along the dimension DIM.
% theethan, 2014

if nargin<2, s = [min(x) ; max(x)]; if size(x,1)==1&&ismatrix(x),s=s.';end
else s = cat(dim, min(x,[],dim), max(x,[],dim));
end