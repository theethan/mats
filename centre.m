function c = centre(a,n)
% CENTRE Extract the central portion of a matrix
%   C = CENTRE(A,N) extracts the central n indices of A for each dimension
%   specified (i.e. n(1) in the first dimension, n(4) in the fourth, etc.).
%   If an element of n is infinite, the entire corresponding dimenion is
%   selected.  If N has fewer elements than A has dimension, the
%   unspecified dimensions are selected in entirety.
% UNFINISHED.
% theethan, 2014

s = size(a); nd = length(s);
n = n(:); n = min( [n ; inf(max(numel(s)-length(n),0),1)].', s );

% is = zeros(n);
% for i=1:nd
%     is = is + bsxfun(@times, ones([(0:n(i)-1).'-floor(n(i)/2)+floor(s(i)/2);
% end; clear i;
is = cell(nd,1);
for i=1:nd
    is = (0:n(i)-1).'-floor(n(i)/2


end
