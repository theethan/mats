function fls = lsrecurse( fpb , varargin )
% LSRECURSE Recursive file-listing in all subdirectories of a directory
%
%   FLS = LSRECURSE( BASE ) gives a list of files FLS as an array of
%   structures with fields as returned by DIR.
%   
%   FLS = LSRECURSE( BASE , PAT ) filters the file list with the regexp 
%   pattern PAT.
%
%   FLS = LSRECURSE( BASE , PAT, ONCE ) returns after finding any file
%   matching the pattern in any subdirectory of BASE.  It returns the DIR
%   information for only that file.
%   
%   LSRECURSE skips hidden (leading '.') files and directories.  The order
%   of directories returned is not specified.
%
% theethan, 2017


% Prepare

rep = false; % default: no matching
one = false;
skiphide = true;
if nargin>1 && ~isempty(varargin{1}), regexppat=varargin{1}; rep=true; end
if nargin>2 && ~isempty(varargin{2}), one=strcmpi(varargin{2},'once'); end
if nargin>3 && ~isempty(varargin{3}), skiphide=varargin{3}; end


% Act

q = dir(fpb); % list of files(/folders) in fbp
if skiphide
    q = q(~strncmp({q.name},'.',1)); % remove hidden files/folders
else
    q = q(~strcmp({q.name},'.')); % remove .
    q = q(~strcmp({q.name},'..')); % remove ..
end

sds = q([q.isdir]); % list of subdirectories
fls = q(~[q.isdir]); % list of files (initialisation)
if rep % trim
    fls = fls( ~cellfun(@isempty,regexp({fls.name},regexppat,'once')) );
end
if one % find the one
    if ~isempty(fls), fls = fls(1); return; end
end
    
while ~isempty(sds) % recurse through all subdirectories
    sd = sds(end); sds = sds(1:end-1); % pop a folder from list
    q = dir([sd.folder '\' sd.name]); % check its contents
    %q = q(~strncmp({q.name},'.',1)); % trim hidden
    if skiphide
        q = q(~strncmp({q.name},'.',1)); % remove hidden files/folders
    else
        q = q(~strcmp({q.name},'.')); % remove .
        q = q(~strcmp({q.name},'..')); % remove ..
    end
    if rep % trim
        q = q(~cellfun(@isempty,regexp({q.name},regexppat,'once')) ...
              | [q.isdir]); % trim all non-directories that don't match
    end
    if one % find the one
        f = q(~[q.isdir]); if ~isempty(f), fls = f(1); return; end
    end
    % {trim & find executed before adding to queue for slight perf. gain}
    sds = [sds ; q([q.isdir])]; % add new folders to list of subdirs
    fls = [fls ; q(~[q.isdir])]; % add new files to list of files
end % now we have a list of all files in any subdirectory of fpb

end