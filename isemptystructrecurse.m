function e = isemptystructrecurse(stc,varargin)
% ISEMPTYSTRUCTRECURSE Check recursively for all fields empty in struct

e = true;

% get fieldnames
fns = fieldnames(stc);

% redact or recurse
for i=1:numel(stc)
    for j=1:length(fns), fn = fns{j};
        if isstruct(stc(i).(fn)) % recurse
            e = e & isemptystructrecurse(stc(i).(fn));
        else % check
            e = e & isempty(stc(i).(fn));
        end
        if ~e, return; end
    end
end


end