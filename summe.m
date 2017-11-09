function summe(me)
% SUMME Summarise a thrown error message
%    SUMME(ME) summarises the structure ME caught as a thrown error message.
% theethan, 2015

% fprintf( '  %s (%s) @ %s:%d\n', ...
%          me.identifier,me.message,me.stack(1).name,me.stack(1).line );
fprintf( '  %s (%s)', me.identifier,me.message );
if ~isempty(me.stack)
    fprintf( ' @ %s:%d',me.stack(1).name,me.stack(1).line );
end
fprintf('\n');

if length(me.stack)>1
    fprintf( '  Trace:\n  > %s:%d\n', me.stack(1).name,me.stack(1).line );
end
for i=2:length(me.stack), spc=' '*ones(1,2*(i-1));
    fprintf('  %s> %s:%d\n',spc,me.stack(i).name,me.stack(i).line);
end; clear i spc;

end
