function fns_cvx(varargin)
% Turns 'on' the installation of CVX.
% theethan, 2014


ethanpath = '/home/ethan/';
cvxpath = [ethanpath 'Documents/MATLAB/cvx'];
here = pwd;

cd(cvxpath);
cvx_setup;
cd(here);

end
