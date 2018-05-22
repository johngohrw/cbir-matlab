% images are resized before any form of processing
% desired resolution of the resized image
resolution = [540; 540];

queryimg = imread('colordataset/red1.jpg');
queryimg = imresize(queryimg,[resolution(1,:) resolution(2,:)]); % resize query image

hsvHist_query = colourhistogram(queryimg);    % getting HSV histogram for query image

cd colordataset;                              % change dir to 'images'
imagefiles = dir('*.jpg');              % get list of all images in 'images' folder
cd ..                                   % change dir back to root folder
numberOfFiles = length(imagefiles);     % Number of images found
for ii=1:numberOfFiles
    currentfilename = join(['colordataset/',imagefiles(ii).name]);
    currentimage = imread(currentfilename);
    
    % resizing to a standard resolution
    currentimage = imresize(currentimage,[resolution(1,:) resolution(2,:)]);
  
    % getting HSV histogram for current image im dataset
    hsvHist_current = colourhistogram(currentimage);
%     figure;
%     imshow(hsvHist_current);
  
    % computing euclidean distance between two histograms
    colorDist = euclideanDistance(hsvHist_query, hsvHist_current);
    
    result = exp(100000/colorDist);
    disp(join([currentfilename,' ',num2str(result)]));
end

% img2 = imread('images/image2.jpg');
% 
% 
% img1 = imresize(img1,[resolution(1,:) resolution(2,:)]);
% img2 = imresize(img2,[resolution(1,:) resolution(2,:)]);
% 
% hsvHist1 = colourhistogram(img1);
% hsvHist2 = colourhistogram(img2);
% 
% colorDist = euclideanDistance(hsvHist1, hsvHist2);
% 
% subplot(1,2,1), imshow(img1);
% subplot(1,2,2), imshow(img2);
% title(colorDist);