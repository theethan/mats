function F = ifft2op( Nx, Ny )
%IFFT2OP Generate operator for 2D DFT on a 'vectorised' matrix.
%   IFFT2OP( NX, NY ) returns an operator (a matrix) which will perform a
%   two-dimensional discrete Fourier transform on a matrix that has been
%   strung out into a vector.
%
%   If A is a matrix, then
%       B = ifft2(A); B = B(:);
%       C = ifft2op( size(A,2), size(A,1) ) * A(:);
%   yield identical B and C (within some numerical tolerance).
%   
%   Practically, this is probably not very useful.
% theethan, 2014


% I'm not sure of a good reason why this works other than checking it
% element-by-element.

if Nx == Ny
    F = ifft( eye( Nx ) );
    F = kron( F, F );
else
    Fx = ifft( eye( Nx ) );
    Fy = ifft( eye( Ny ) );
    F = kron( Fx, Fy );
end

end
