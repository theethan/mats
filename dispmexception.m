function dispmexception(e)
% DISPMEXCEPTION Give a short summary of a MException object
% 
%   DISPMEXCEPTION( ME ) prints a relatively concise rendering of the error
%   message and process stack.
%
% theethan, 2017

o = [91 8]; c = [93 8]; % open and close markers for warnings

s = e.stack; l = length(e.stack);

% error summary
fprintf([o '%s (%s) ' c '\n'],e.identifier,e.message);

% stack summary
if isempty(s), return; end
fprintf([o '[ %s (%d) ' c],s(l).name,s(l).line);
for i=l-1:-1:1, fprintf([o '-> %s (%d) ' c],s(i).name,s(i).line); end
fprintf([o ']' c '\n']);

end