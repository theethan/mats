function b = satval(a,w)
% SATVAL Clip data values to within an intensity window
%   B = SATVAL(A,W) saturates the values of A into the range W, (e.g., any
%   value greater than max(w) clips to max(w)).
% theethan, 2014

if numel(w)~=2, b = nan(size(a));
else w = sort(w(:)); b = a; b(b>w(end)) = w(end); b(b<w(1)) = w(1);
end

end