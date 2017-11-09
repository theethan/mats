function s = srl(b,n)
% SLL Shift-right logical (>>>)
%   S = SLL( B, N ) shifts B right by N bits, shifting in zeros.  N<0 is an
%   error.
% theethan, 2013

if( n < 0 ), error('PROBLEM IN SRL.m'); end

s = bitand( bitshift(b,-n), ((2^n)-1) );
