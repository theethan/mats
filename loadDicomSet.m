% General recon & processing
% filename: loadDicomSet.m
%     to load a series of DICOM files
% Modified:
% 
% 2008/10/09 
% Hochong Wu
%
% 2013/06/18 (and a few other times before)
% theethan

% close all; clear all;
% clear all;

% Flags
% ========================================================================
% - Plot imgs -
CONST_WND = 1; % window images (scalar T/F or vector w/ frac. of min./max.)
PLOT_IMGS = 0; % display all images in a separate figure

% - Save imgs -
WRITE_IMS   = 0; % save recon as an axial tiff image series
WRITE_SAG = 1; % also output a reformatted sagittal series
WRITE_COR = 1; % also output a reformatted coronal series
SAVE_RECON  = 0; % save recon as a .mat file
% ========================================================================


% Specify dataset
LOAD_PATH = '~/Pictures/head';
date      = '2013_06_18';
examNo    = 12151;
% seriesNo  = 1;                                                             sls = textscan(ls(sprintf('%s/%s/e%ds%di*',LOAD_PATH,date,examNo,seriesNo),'-l'),'%s\n'); Nsis = length(sls{1});
seriesNo  = 2;                                                             Nsis=length( find(ls(sprintf('%s/%s/e%ds%di*',LOAD_PATH,date,examNo,seriesNo),'-l')==10) );
Nsl       = Inf;
%load_sl   = [1:10:96]; %slices to load
load_sl   = 1:min(Nsl,Nsis); clear Nsis;% sls;

filestr  = sprintf( 'e%ds%d', examNo,seriesNo );

% Read all the DICOM images
fprintf('loading %s\n', filestr); time=tic;
clear imgMat;
for count=1:numel(load_sl),
    slice = load_sl(count);
%     filename = sprintf('%s/%s/dcm/%si%d',LOAD_PATH,date,filestr,slice);
    filename = sprintf('%s/%s/%si%d',LOAD_PATH,date,filestr,slice);
    info = dicominfo( filename );
    
    if(count==1), imgMat=zeros(info.Height,info.Width,numel(load_sl)); end
    % Convert to double (the default is uint16)
    imgMat(:,:,count) = double(dicomread(info));
end
imgN = size(imgMat,1);


wnd = [];
if( CONST_WND(end)>0 )
    w_max = max( abs(imgMat(:)) );
    w_min = min( abs(imgMat(:)) );
    
    if( numel(CONST_WND)>1 )
        wnd = [CONST_WND(1)*w_max, CONST_WND(end)*w_max];
    else    
        wnd = [w_min, CONST_WND(end)*w_max];
    end
end

time=toc(time);
fprintf('done (%f seconds)\n',time);

if( PLOT_IMGS )
% ========================================================================
% Plot results
for count=1:numel(load_sl),
    imgPlot = reshape( imgMat(:, :, count), imgN,imgN );
    
    figure; 
    if( CONST_WND>0 )
        imagesc( abs(imgPlot), wnd ); 
    else
        imagesc( abs(imgPlot) );
    end    
    colormap gray; truesize; axis image; 
    title(sprintf('img, slice %d/%d', load_sl(count),Nsl));
end    
% ========================================================================
end % PLOT_IMGS


% function assumes img is [N N Nsl]
if( WRITE_IMS )
% ========================================================================
    SAVE_DIR = sprintf('%s/%s/Axl/', date,filestr);
    filename = sprintf( '%s/%s_axl', SAVE_DIR,filestr );
    if( ~exist(SAVE_DIR, 'dir') )
        mkdir( SAVE_DIR );
    end
        
    tiffserieswrite( imgMat, filename, [], wnd, 1 );

    if( WRITE_SAG )
    % --------------------------------------------------------------------    
    SAVE_DIR = sprintf('%s/%s/Sag/', date,filestr);
    filename = sprintf( '%s/%s_sag', SAVE_DIR,filestr );
    if( ~exist(SAVE_DIR, 'dir') )
        mkdir( SAVE_DIR );
    end
    
    tiffserieswrite( imgMat, filename, [], wnd, 2 );
    % --------------------------------------------------------------------
    end
    
    if( WRITE_COR )
    % --------------------------------------------------------------------    
    SAVE_DIR = sprintf('%s/%s/Cor/', date,filestr);
    filename = sprintf( '%s/%s_cor', SAVE_DIR,filestr );
    if( ~exist(SAVE_DIR, 'dir') )
        mkdir( SAVE_DIR );
    end
    
    tiffserieswrite( imgMat, filename, [], wnd, 3 );
    % --------------------------------------------------------------------
    end    
% ========================================================================    
end

if( SAVE_RECON )
    SAVE_DIR = sprintf('%s/', date);
    if( ~exist(SAVE_DIR, 'dir') )
        mkdir( SAVE_DIR );
    end
    
    filename = sprintf( '%s/%s.mat', SAVE_DIR,filestr );
    save(filename, '-mat', 'imgMat');
end

