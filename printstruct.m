function printstruct(stc,varargin)
% PRINTSTRUCT recursively print contents of struct (or array of structs)

if nargin<2, o = ''; else, o = [varargin{1} '  ']; end % space offset

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
%             if ischar(stc(i).(fn)), fmtstr = '%s%s: ''%s''\n';
%             elseif isnumeric(stc(i).(fn)), fmtstr = '%s%s: %f\n';
%             else, fmtstr = '%s%s: {%s}\n';
%             end
%             fprintf(fmtstr,o,fn,stc(i).(fn));
            % determine format string
            if ischar(stc(i).(fn)), fs = ' ''%s''';
            elseif isnumeric(stc(i).(fn)), fs = ' %f';
            else, fs = ' {%s}';
            end
            % display
            fprintf('%s%s:',o,fn);
            %for k=1:length(stc(i).(fn)), fprintf(fs,stc(i).(fn)(k)); end
            fprintf(fs,stc(i).(fn));
            fprintf('\n');
%             fprintf('%s%s:',o,fn);
%             if ischar(stc(i).(fn)), fv = sprintf(' ''%s''',stc(i).(fn));
%             elseif isnumeric(stc(i).(fn)), fv = sprintf(' %f',stc(i).(fn));
%             else, fv = sprintf(' {%s}',stc(i).(fn));
%             fprintf('\n');
        end
    end
    fprintf('%s-----\n',o);
end


end