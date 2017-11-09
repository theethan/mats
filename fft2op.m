function F = fft2op( Nx, Ny )
%FFT2OP Generate operator for 2D DFT on a 'vectorised' matrix.
%   FFT2OP( NX, NY ) returns an operator (a matrix) which will perform a
%   two-dimensional discrete Fourier transform on a matrix that has been
%   strung out into a vector.
%
%   If A is a matrix, then
%       B = fft2(A); B = B(:);
%       C = fft2op( size(A,2), size(A,1) ) * A(:);
%   yield identical B and C (within some numerical tolerance).
%   
%   Practically, this is probably not very useful.
% theethan, 2014


% I'm not sure of a good reason why this works other than checking it
% element-by-element.

if Nx == Ny
    F = fft( eye( Nx ) );
    F = kron( F, F );
else
    Fx = fft( eye( Nx ) );
    Fy = fft( eye( Ny ) );
    F = kron( Fx, Fy );
end

end
