function h = imview( varargin )
% Adaptation of imagesc
% theethan, 2011(?)

% 'Constant'
ARLIMIT = 8; % aspect ratio limit for displaying square pixels

% Function
clim = [];
switch (nargin),
  case 0,
    hh = image('CDataMapping','scaled');
  case 1,
    im = varargin{1};
    if( sum(abs(imag(im(:)))) ~= 0 ); im = abs(im); end
    ar = size(im,1)/size(im,2);
    hh = image(im,'CDataMapping','scaled');
  case 3,
    im = varargin{3};
    if( sum(abs(imag(im(:)))) ~= 0 ); im = abs(im); end
    ar = size(im,1)/size(im,2);
    varargin{3} = im;
    hh = image(varargin{:},'CDataMapping','scaled');
    if size(im,1)~=size(im,2) ...
       && size(im,1)==length(varargin{1})&&size(im,2)==length(varargin{2})
        warning('First two arguments might be swapped.');
    end
  otherwise,

    % Determine if last input is clim (--wow, that is roundabout!)
    if isequal(size(varargin{end}),[1 2])
      str = false(length(varargin),1);
      for n=1:length(varargin)
        str(n) = ischar(varargin{n});
      end
      str = find(str);
      if isempty(str) || (rem(length(varargin)-min(str),2)==0),
        clim = varargin{end};
        varargin(end) = []; % Remove last cell
      else
        clim = [];
      end
    else
      clim = [];
      varargin = varargin(1:end-1); % hack??
    end
    
    if isvector(varargin{1}) && nargin>2; argnum = 3; else argnum = 1; end
    im = varargin{argnum};
    if( sum(abs(imag(im(:)))) ~= 0 ); im = abs(im); end
    ar = size(im,1)/size(im,2);
    varargin{argnum} = im;
    hh = image(varargin{:},'CDataMapping','scaled');
end

% Get the parent Axes of the image
cax = ancestor(hh,'axes');

if ~isempty(clim),
  set(cax,'CLim',clim)
elseif ~ishold(cax),
  set(cax,'CLimMode','auto')
end

if( 1/ARLIMIT < ar && ar < ARLIMIT ); axis image; end;
if strcmpi(get(gca,'ActivePositionProperty'),'outerposition')
    if strcmpi(get(gca,'Visible'),'on')
        set(gca,'Position',[0.092 0.1 0.86 0.85]);
    else
        set(gca,'Position',[0.02 0.04 0.96 0.92-(ar>1)*0.04]);
    end
end

if nargout > 0
    h = hh;
end


end