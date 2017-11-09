function img = getDicom(prefix, num_slice)

% prefix = 'e5880s1i'; %The prefix of each DICOM file
% num_slice = 92; %The number of slices

%figure
% Read all the DICOM images
for slice=1:num_slice;
    ind = slice; filename = sprintf('%s%d',prefix,ind);
    fprintf('slice %d [%s]\n',slice,filename); % display slice number/name
    info = dicominfo(filename);
    % Convert to double - the default is uint16
    img(:,:,slice) = double(dicomread(info));
end
