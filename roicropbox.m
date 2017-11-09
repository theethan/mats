function [cr,varargout] = roicropbox( im, varargin )
% ROICROPBOX Select a box from a volume for cropping
%   
%   CR = ROICROPBOX(IM) solicits input for how to crop the image volume IM
%   and returns the x, y and z crop indices limits as CR(:,1), etc.
% 
%   NOTE: treats dims. 1 & 2 as 'y' and 'x'.
%
% theethan, 2016


% --- Prepare ---

%ww = spread(abs(im(:))); ww=(ww-mean(ww)).*[0.5;0.5]+mean(ww); % intensity
ww = [0 max(abs(im(:)))*0.213]; % intensity
[sy,sx,sz,~] = size(im);


% --- Parse ---
if nargin>1 && ~isempty(varargin{1}), ww = varargin{1}; end


% --- Prompt ---

% Select slice
t = cell(1,sz);
for i=1:sz, t{i} = sprintf('%3d/%3d [exit on desired slice]',i,sz); end;
[a,iz] = displaystack(im,t,ww); if ~a, iz = floor(sz/2)+1; end
clear t i;

% Get crop
fig=figure;
imshow(im(:,:,iz),ww);
% Axial cropping
title('select dims. 1 & 2 crop corner 1 [ENTER to skip]');
% Get a click
while true
    [cx,cy] = ginput(1);
    if isempty(cx)||isempty(cy), cr = []; break; end
    if( (1-0.05*(sx-1)<cx&&cx<1) ), cx = 1; end % grace region
    if( (sx<cx&&cx<sx+0.05*(sx-1)) ), cx = sx; end
    if( (1-0.05*(sy-1)<cy&&cy<1) ), cy = 1; end
    if( (sy<cy&&cy<sy+0.05*(sy-1)) ), cy = sy; end
    if( cx<1||cx>sx || cy<1||cy>sy ), continue; end % reject
    cr = round([cx cy]); break;
end; clear cx cy;
% Update display
if ~isempty(cr)
    % Show last click
    figure(fig);
    hold on;
    plot([cr(1)*[1;1] xlim.'],[ylim.' cr(2)*[1;1]],'r--','LineWidth',1);
    hold off;
else cr = [1 1;sx sy];
end
% Get another click
title('select dims. 1 & 2 crop corner 2 [ENTER to cancel]');
while true && ~isempty(cr)
    [cx,cy] = ginput(1);
    if isempty(cx)||isempty(cy), cr = []; break; end
    if( cx<1||cx>sx || cy<1||cy>sy ), continue; end
    cr = [cr ; round([cx cy])]; break;
end; clear cx cy;
% Update display
if ~isempty(cr)
    % Show last click
    figure(fig);
    hold on;
    plot([cr(2)*[1;1] xlim.'],[ylim.' cr(4)*[1;1]],'r--','LineWidth',1);
    hold off;
    title('dims. 1 & 2 crop region selected!'); pause;
    % Sort the crop points
    cr = sort(cr);
    % Make a mask to display
    [nx,ny] = meshgrid(1:sx,1:sy);
    mskcr = ( (cr(1)<nx & nx<cr(2) & cr(3)<ny & ny<cr(4)) +0.0213)/1.0213;
    clear nx ny;
    % Show the masked image
    figure(fig);
    imshow((im(:,:,iz)-ww(1)).*mskcr,ww-ww(1)); clear mskcr;
    title('dims. 1 & 2 crop region higlighted.'); pause;
    % Prepare for sagittal cropping
    imc = reformat(im(:,floor(mean(cr(1:2)))+1,:),'axi','sag');
    [nx,ny] = meshgrid(1:sy,1:sz);
    mskcr = ( (cr(3)<nx & nx<cr(4)) +0.0213)/1.0213;
    figure(fig);
    imshow((imc-ww(1)).*mskcr,ww-ww(1));
    clear mskcr
end
% Sagittal cropping
title('select dim. 3 crop bounds [ENTER to cancel]');
% Get a click
while true && ~isempty(cr)
    [cx,cy] = ginput(1);
    if isempty(cx)||isempty(cy), cr = []; break; end
    if( cy<1||cy>sz ), continue; end
    cr = [cr [round(cy);0]]; break;
end; clear cx cy;
% Update display
if ~isempty(cr)
    % Show last click
    figure(fig);
    hold on;
    plot(xlim,cr(5)*[1 1],'r--','LineWidth',1);
    hold off;
end
% Get a click
while true && ~isempty(cr)
    [cx,cy] = ginput(1);
    if isempty(cx)||isempty(cy), cr = []; break; end
    if( cy<1||cy>sz ), continue; end
    cr(6) = round(cy); break;
end; clear cx cy;
% Update display
if ~isempty(cr)
    % Show last click
    figure(fig);
    hold on;
    plot(xlim,cr(6)*[1 1],'r--','LineWidth',1);
    hold off;
    title('dim. 3 crop bounds selected!'); pause;
    % Translate and sort the new crop points
    cr(:,3) = sort(sz-cr(:,3)+1);
    % Make a mask to display
    [nx,ny] = meshgrid(1:sy,sz:-1:1);
    mskcr = ( (cr(3)<nx & nx<cr(4) & cr(5)<ny & ny<cr(6)) +0.0213)/1.0213;
    clear nx ny;
    % Show the masked image
    figure(fig);
    imshow((imc-ww(1)).*mskcr,ww-ww(1)); clear mskcr;
    title('dims. 1 & 3 crop region higlighted.'); pause;
end
clear imc;
close(fig); clear fig;


% --- Process ---

% Make mask
if nargout>1 
    [nx,ny,nz] = meshgrid(1:sx,1:sy,1:sz);
    mskcr = cr(1)<nx&nx<cr(2) & cr(3)<ny&ny<cr(4) & cr(5)<nz&nz<cr(6);
    varargout{1} = mskcr;
end

% Do crop
if nargout>2
    % Crop images
    varargout{2} = im(cr(3):cr(4),cr(1):cr(2),cr(5):cr(6));
end


%--done!

end