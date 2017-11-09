function [x,y,z] = randpdsph(r,varargin)
% RANDPDSPH Generate Poisson-disc-sampled points on a spherical surface
% 
%   [X,Y,Z] = RANDPDSPH(R) generates a collection of points (X,Y,Z) with
%   random distribution on the surface of a radius-0.5 sphere that satisfy
%   the minimum-distance requirement specified by R using the Brindson
%   method (without using the background grid) and an approximation from a
%   planar annulus to a sphere.
%
%   [X,Y,Z] = RANDPDSPH(R,K) limits the number of trials for a candidate to
%   K before rejection [default: 30].
%   
%   [X,Y,Z] = RANDPDSPH(R,K,B) places the points on a sphere of radius B.
%   
%   RANDPDSPH uses the RAND function in its current/existing state.
%   
% theethan, 2016

% Defaults
k = 30; % limit of samples before rejection
b = 0.5; % radius of spherical surface

% Parse
if nargin>1 && ~isempty(varargin{1}), k = varargin{1}; end;
if nargin>2 && ~isempty(varargin{2}), b = varargin{2}; end;

% Shortcuts/precomputations
r2 = r^2; % for exclusion radius
b2 = b^2; % for annulus-to-sphere wrapping-shrink factor
p0 = acos(1-r2/2/b2); % vertex angle of isoc triangle w/ sides b,b,r
p1 = acos(1-2*r2/b2); % vertex angle of isoc triangle w/ sides b,b,2r
dt = 2*pi; cp0 = cos(p0); dcp = cos(p1)-cos(p0);

% Make list of samples
l = zeros(10,3); n = 0;

% Make queue (kind of; really just a list b/c processed in random order)
q = zeros(10,3); s = 0;

% Initialise
a = 2*pi*rand; i = acos(2*rand-1); % draw uniformly random sphere surface
p0 = b*[sin(i)*[cos(a) sin(a)] cos(i)]; % cartesian coordinates
clear a i;
n = n+1; l(n,:) = p0; % save in list
s = s+1; q(s,:) = p0; % add to queue

% Add points
while s>0
    % First check for size overrun
    if n==size(l,1), ll=zeros(2*n,3); ll(1:n,:)=l; l=ll; clear ll; end
    if s==size(q,1), qq=zeros(2*s,3); qq(1:s,:)=q; q=qq; clear qq; end
    % Then proceed to select point in the grid
    i = floor(rand*s)+1;
    % And generate candidate(s)
    c = false; % is it a candidate?
    for j=1:k % try at most k times
        ri = norm(q(i,:)); % radius for selected point
        ai = atan2(q(i,2),q(i,1)); ii = acos(q(i,3)/ri); % azim. & incl. angle
        aj = dt*rand; oj = acos(cp0+rand*dcp); % uniformly-random point in
        pj = b*[sin(oj)*[cos(aj) sin(aj)] cos(oj)]; % 'spherical rectangle'
        pj = (rotz(ai*180/pi)*roty(ii*180/pi) * pj.').';
        if ( ~tooprox( pj, l(1:n,:), r ) ) % in bounds & not close?
            n = n+1; l(n,:) = pj; % save in list
            s = s+1; q(s,:) = pj; % add to queue
            c = true; % signal that candidate was found
            break; % quit making candidates
        end
    end
    if ~c, q(i,:) = q(s,:); s = s-1; end % remove point from queue
end; clear i j aj rj ri ai ii;

% Return
x = l(1:n,1); y = l(1:n,2); z = l(1:n,3);

end


function tp = tooprox(p,l,e)
% TOOPROX Check for too-proximal point relative to list of points
%  + P is the point as an n-tuple (row-vector)
%  + L is the list of points with n-tuples across and different points down
%  + E is the exclusion distance (2-norm of P-L)

d = sum( bsxfun(@plus,-p,l).^2, 2);

tp = any( d < (e^2) );

end