
% threshold input from user
euclideanThreshold = 5000;

%Make an array


% gabor filter arguments
gamma = 1;
psi = 0.1;
theta = 90;
bw = 2.8;
lambda = 3.5; 
pi = 180;

[filename, pathname] = uigetfile({'*.jpg;*.png;*.gif;*.bmp', 'All Image Files (*.jpg, *.png, *.gif, *.bmp)'; ...
                '*.*',                   'All Files (*.*)'}, ...
                'Pick an image file', 'MultiSelect', 'on');
image = imread([pathname,filename]);
     
%imshow(image, 'Parent', app.UIAxes);

hsvhistQuery = colourhistogram(image);

gaborImg = myGabor(image, gamma, psi, theta, bw, lambda, pi);
gaborImgMean = mean(gaborImg);

%create an array of zeros
histData_1 = zeros(1, numberOfFiles);
file_names = {};

% Get list of all JPG files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
cd images;                      % change dir to 'images'
imagefiles = dir('*.jpg');      
numberOfFiles = length(imagefiles);  % Number of files found
for ii=1:numberOfFiles
    currentfilename = imagefiles(ii).name;
    currentimage = imread(currentfilename);
%   images{ii} = currentimage;  % i dont know what this line is for
    % do stuff here..
    % disp(ii)
    %imshow(currentimage);
    hsvhistData = colourhistogram(currentimage);
    %disp(hsvhistData)
    result_colour = euclideanDistance(hsvhistQuery, hsvhistData);
    histData_1(1, ii) = result_colour;
    file_names = [file_names; {currentfilename}]; 
end
cd ..                           % change dir back to root folder

%sort the lowest euclidean distance 
%disp(file_names);
[firstOrder, sortedOrder] = sort(histData_1);
new_fileresults = file_names(sortedOrder);
firstOrder = firstOrder(:, 1:numberOfFiles/2);
%disp(firstOrder);
new_fileresults(numberOfFiles/2:end-1, :) = [];


%create an array of zeros
mean_data1 = zeros(1, length(new_fileresults));
second_file_names = {};

% Get list of all JPG files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
cd images;                      % change dir to 'images'
imagefiles = dir('*.jpg');      
new_numberOfFiles = length(new_fileresults);  % Number of files found
disp(new_numberOfFiles);
for ii=1:new_numberOfFiles
    currentfilename = imagefiles(ii).name;
    currentimage = imread(currentfilename);
%   images{ii} = currentimage;  % i dont know what this line is for
    % do stuff here..
    %disp(ii)
    %imshow(currentimage);
    gabor_data = myGabor(currentimage, gamma, psi, theta, bw, lambda, pi);
    gaborMean = mean(gabor_data);
    gaborStd = std(gaborStd);
    result_mean = euclideanDistance(gaborImgMean, gaborMean);
    result_std = euclideanDistance(gaborImgStd, gaborStd);
    mean_data1(1, ii) = result_mean;
    second_file_names = [second_file_names; {currentfilename}]; 
end
cd ..                           % change dir back to root folder

%sort the lowest euclidean distance 
%disp(file_names);
[firstOrder, sortedOrder] = sort(mean_data1);
new_second_fileresults = second_file_names(sortedOrder);
firstOrder = firstOrder(:, 1:new_numberOfFiles/2);
new_second_fileresults(new_numberOfFiles/2:end-1, :) = [];


image1 = imread('image2_3.jpg');
% gabor
gabor1 = myGabor(image1, gamma, psi, theta, bw, lambda, pi);
gaborMean1 = mean(gabor1);
gaborStd1 = std(gabor1);
% hsv histogram
hsvhist1 = colourhistogram(image1);
% disp(hsvhist1)

image2 = imread('image2.jpg');
% gabor
gabor2 = myGabor(image2, gamma, psi, theta, bw, lambda, pi);
gaborMean2 = mean(gabor2);
gaborStd2 = std(gabor2);
%hsv histogram
hsvhist2 = colourhistogram(image2);
% disp(hsvhist2);    

% euclideanDistance(hsvhist1, hsvhist2);
result_mean = euclideanDistance(gaborMean1, gaborMean2);
result_std = euclideanDistance(gaborStd1, gaborStd2);
disp(result_std);
if result_std < 0.05 && result_mean < 1
         disp('similar images');
         %result = 'similar';
     else
         disp('dissimilar images');
         %result = 'dissimilar';
end

close all;