function s = struct2string(stc,varargin)
% STRUCT2STRING recursively print contents of struct (or array of structs)

% set defaults
c = '-'; % character for level indicator
o = ''; % space offset

% parse
if nargin>1, c = varargin{1}; end;
if nargin>2&&~isempty(varargin{2}), o = [varargin{2} '  ']; end

% initialise
s = '';
l = strrep(sprintf('%5s',' '),' ',c); % level indicator

% get fieldnames
fns = fieldnames(stc);

% redact or recurse
for i=1:numel(stc)
    s = [s sprintf('%s%s\n',o,l)];
    for j=1:length(fns), fn = fns{j};
        if isstruct(stc(i).(fn)) % recurse
            s = [s sprintf('%s%s: (struct)\n',o,fn)];
            s = [s struct2string(stc(i).(fn),c,o)];
        else % print
            fv = stc(i).(fn);
            % determine format string
            if ischar(fv), fs = ' ''%s''';
            elseif isnumeric(fv), fs = ' %f'; fv = fv(1:min(numel(fv),20));
            elseif islogical(fv), fs = ' %d'; fv = fv(1:min(numel(fv),20));
            else, fs = ' {%s}'; fv = fv(1:min(numel(fv),40));
            end
            % display
            s = [s sprintf('%s%s:',o,fn)];
            s = [s sprintf(fs,fv)];
            s = [s sprintf('\n')];
        end
    end
    s = [s sprintf('%s%s\n',o,l)];
end


end