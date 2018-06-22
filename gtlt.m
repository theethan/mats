function tf = gtlt( x , l , e )
% GTLT Greater than lower bound and less than upper bound ('between')
%   
%   TF = GTLT( X , L , [E] ) compares x to the lower bound L(1) and to the 
%   upper bound L(2), i.e. it checks whether or not x is between L(1) and 
%   L(2).  A logical array the same size as x is returned.  Optional
%   argument E specifies equality in the compator (greater-/lesser-or-equal 
%   vs. strictly greater/lesser) [default: false, i.e. strictly].
%   
% theethan, 2018

if ~exist('e','var')||isempty(e), e = false; end

if e
    tf = l(1) <= x & x <= l(2);
else
    tf = l(1) < x & x <= l(2);
end

end