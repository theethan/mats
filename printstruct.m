function printstruct(stc,varargin)
% PRINTSTRUCT recursively print contents of struct (or array of structs)

%if nargin>1&&~isempty(varargin{1}), o=[varargin{1} '  ']; else, o=''; end
if nargin>1, o=[varargin{1} '  ']; else, o=''; end

% get fieldnames
fns = fieldnames(stc);

% redact or recurse
for i=1:numel(stc)
    fprintf('%s-----\n',o);
    for j=1:length(fns), fn = fns{j};
        if isstruct(stc(i).(fn)) % recurse
            fprintf('%s%s: (struct)\n',o,fn);
            printstruct(stc(i).(fn),o);
        else % print
            fv = stc(i).(fn);
            % determine format string
            if ischar(fv), fs = ' ''%s''';
            elseif isnumeric(fv), fs = ' %f'; fv = fv(1:min(numel(fv),20));
            elseif islogical(fv), fs = ' %d'; fv = fv(1:min(numel(fv),20));
            else, fs = ' {%s}'; fv = fv(1:min(numel(fv),40));
            end
            % display
            fprintf('%s%s:',o,fn);
            fprintf(fs,fv);
            fprintf('\n');
        end
    end
    fprintf('%s-----\n',o);
end


end