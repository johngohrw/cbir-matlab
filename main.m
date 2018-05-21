
% threshold input from user
euclideanThreshold = 5000;

% gabor filter arguments
gamma = 1;
psi = 0.1;
theta = 90;
bw = 2.8;
lambda = 3.5; 
pi = 180;

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
    disp(ii)
    imshow(currentimage);
end
cd ..                           % change dir back to root folder

image1 = imread('image1.jpg');
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


close all;