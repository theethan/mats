function val = getfieldrecurse( stc , fld , varargin )
% GETFIELDRECURSE Retrieve all fields of a certain name in a nested struct
%   VAL = GETFIELDRECURSE( STC , FLD ) searches the struct STC for all
%   fields with the name FLD and returns a list of values (as a cell array)
%   for all matching fields.
%
%   VAL = GETFIELDRECURSE( STC , FLD , TRUE ) stops after finding one field
%   with a matching name.
% theethan, 2018

% Default
val = {};
one = false;

% Parse
if nargin>2 && ~isempty(varargin{1}), one = varargin{1}; end

% Top level?
if isfield(stc,fld), val = [val {stc.(fld)}]; end

% Any sub-level
fns = fieldnames(stc);
for i=1:length(fns)
    if ~isempty(val) && one, return; end
    if isstruct(stc.(fns{i}))
        valrec = getfieldrecurse( stc.(fns{i}) , fld );
        if ~isempty(valrec)
            val = [val valrec]; % append
        end
    end
end

end