function e = seteq(a,b)
% SETEQ Test 'set equality'.
%   E = SETEQ(A,B) checks whether numerical sets A and B contain the same 
%   elements.  This is implemented in a very simple fashion.
% theethan, 2014

a = sort(a(:),'ascend'); b = sort(b(:),'ascend');

if numel(a)~=numel(b), e = false; return; end

e = ~any(a~=b);

end