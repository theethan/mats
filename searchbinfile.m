function [idcs,varargout] = searchbinfile(fn,dt,varargin)
% SEARCHBINFILE
%   [IDCS,FHDR,FHSZ] = SEARCHBINFILE(FN,DT,[QV],[SZ],[BL]) tries every byte
%   offset for interpretation of the file as a particular data type DT and 
%   optionally searches for a particular value QV.
%   Input:
%     + FN is the file-name for p-file
%     + DT is the data-type used for interpreting header (spec. as string)
%       possible values: uint16, uint32, uint64, float
%     + QV is the value for which to query (optional)
%     + SZ is the upper limit of byte-offsets to read from file (optional)
%       [default: entire file]
%     + BL is the endianness (big/little) to use in interpreting the file
%       (optional) [default: match to computer]
%   Output:
%     + IDCS contains the indices at which the query-value was identified
%     + FHDR contains the full header read/interpreted at every byte offset
%     + FHSZ gives the number of bytes read from the file.
%     Any found queries will be located at qf(qi+1).


% Internal references
AOO = 0; % 'argout offset' (number of required output arguments - 1)
[~,~,en] = computer; % endianness (assumed 'B' or 'L')


% -----
% model
% --
% fid=fopen('p/2013-10-11/P61440.7');
% q=cell(1,1e7);
% i=0; while fseek(fid,i,-1)==0, q(i+1)={fread(fid,1,'uint32')}; i=i+1; end
% q=cell2mat(q(1:i));
% -----


% Defaults
qv = []; fhsz = inf;
bl = en;


% Parse
if nargin>2 && ~isempty(varargin{1}), qv = varargin{1}; end
if nargin>3 && ~isempty(varargin{2}), fhsz = varargin{2}; end
if nargin>4 && ~isempty(varargin{3}) && ischar(varargin{3})
    bl = upper(varargin{3}(1)); if (bl~='B' && bl~='L'), bl = en; end
end
if strcmpi(dt,'float'), dt = 'single'; end
% ---maybe check types here.


% Open
fid=fopen(fn);
if fid<0
   error('***Failed to open file %s\n',fn); % give some feedback
   %idcs=[]; varargout(1:nargout-AOO-1) = {[]}; return; % then give up
end


% Prepare
finf = dir(fn); fhsz = min(finf.bytes,fhsz);
dtsz = type2byte({dt}); ndps = ceil(fhsz/dtsz); % elements size," per shift
ds = zeros(ndps,dtsz,dt);


% Read
db = fread(fid,fhsz,'uint8=>uint8'); % data as bytes
% if bl~=en % flip endianness if needed
%     db(1:floor(fhsz/dtsz)*dtsz) = ...
%         reshape( flip( reshape( db(1:floor(fhsz/dtsz)*dtsz) ...
%                                 , dtsz, [] ) ...
%                        , 1 ) ...
%                  , [], 1 );
% end
% % -- actually need to do this with the right offset each time; can't just
% %    do it once!
db = [ db ; zeros((ndps+1)*dtsz-1-fhsz,1) ]; % padded with zeros


% Chunk
for i=1:dtsz
    dbi = db(i+(0:end-dtsz));
    if bl~=en % flip endianness if needed
        dbi = reshape( flip( reshape( dbi , dtsz, [] ) , 1 ) , [], 1 );
    end
    ds(:,i) = typecast(dbi,dt); % typecast each column
end; clear i;
d = reshape(ds.',[],1); % string it back out


% Search (if requested)
if isempty(qv), idcs = []; else, idcs = find(d==qv)-1; end


% Also give the full header at each offset if requested
i = 1;
if nargout>i+AOO, varargout(i) = {d}; end; i=i+1;
if nargout>i+AOO, varargout(i) = {fhsz}; end


end