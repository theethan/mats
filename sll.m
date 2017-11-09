function s = sll(b,n)
% SLL Shift-left logical (<<)
%   S = SLL( B, N ) shifts B left by N bits, shifting in zeros.  N<0 is an
%   error.
% theethan, 2013

if( n < 0 ), error('PROBLEM IN SLL.m'); end

s = bitshift(b,n);
