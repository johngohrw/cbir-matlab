
% images are resized before any form of processing
% desired resolution of the resized image
resolution = [540; 540];

% hardcoded query input image, 
queryimg = imread('images/image1.jpg');
queryimg = imresize(queryimg,[resolution(1,:) resolution(2,:)]); % resize query image

% threshold input from user
similarityThreshold = 0.5;

% gabor filter arguments
gamma = 1;
psi = 0.1;
theta = 90;
bw = 2.8;
lambda = 3.5; 
pi = 180;

% getting HSV color histogram for the query image
colorHistQuery = colorHistogram(queryimg);

% Getting the mean and standard Gabor feature vectors for the query image
gaborQuery = myGabor(queryimg, gamma, psi, theta, bw, lambda, pi);
gaborMeanQuery = mean(gaborQuery);
gaborStdQuery = std(gaborQuery);

% Get list of all JPG files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
dirName = 'images';
oldFolder = cd(dirName);             % change dir to dirName
imagefiles = dir('*.jpg');           % get image file names in this folder
cd(oldFolder)                        % change dir back to root folder
numberOfFiles = length(imagefiles);  % Number of files found

% Euclidean Value Distance Results
% row 1: color histogram euclidean values
% row 2: gabor filter mean euclidean values
% row 3: gabor filter standard deviation euclidean values
euclideanDistances = zeros(numberOfFiles, 3);

% Similarity values in percentage
% row 1: color histogram similarity values
% row 2: gabor filter mean similarity values
% row 3: gabor filter standard deviation similarity values
similarityValues = zeros(numberOfFiles, 3);

% Initialising list of filenames
fileNames = {};

% loops each image file
for ii=1:numberOfFiles
    % get current file name, read current image
    currentfilename =  join([dirName,'/',imagefiles(ii).name]);
    currentimage = imread(currentfilename);
    
    % update file names row
    fileNames = [fileNames; currentfilename];
    
    % resizing curr image to a standard resolution
    currentimage = imresize(currentimage,[resolution(1,:) resolution(2,:)]);
    
    % Calculate euclidean distance with color histogram
    colorHistCurrent = colorHistogram(currentimage);
    colorDist = euclideanDistance(colorHistQuery, colorHistCurrent);
    euclideanDistances(ii, 1) = colorDist;
    
    % Calculate euclidean distances for mean and
    % standard deviation of Gabor filter
    currentGabor = myGabor(currentimage, gamma, psi, theta, bw, lambda, pi);
    currentGaborMean = mean(currentGabor);
    currentGaborStd = std(currentGabor);
    resultMean = euclideanDistance(gaborMeanQuery, currentGaborMean);
    resultStd = euclideanDistance(gaborStdQuery, currentGaborStd);
    euclideanDistances(ii, 2) = resultMean;
    euclideanDistances(ii, 3) = resultStd;
end

%%% FILTERING

threshold = similarityThreshold;

% 1 = color histogram, 2 = mean gabor, 3 = std gabor
firstPassFilter = 3;
secondPassFilter = 1;


%%% FIRST PASS SORTING AND FILTERING

% sort by euclidean distance of first pass filter, most similar images first
[euclideanDistances, sortedIndexes] = sortrows(euclideanDistances,firstPassFilter);

% sorting fileNames array accordingly 
len = length(euclideanDistances);
newFileNames = {};
for ii = 1:len
    newFileNames = [newFileNames; fileNames(sortedIndexes(ii,1),1)];
end
fileNames = newFileNames;

firstPassSortedIndexes = sortedIndexes;
firstPassFileNames = fileNames;

% getting highest EuclideanDist value as the benchmark for 0% similarity
% a Euclidean Distance of 0 will be considered 100% similarity
maxDist = euclideanDistances(length(euclideanDistances),firstPassFilter);

% Computing similarity values for first filter pass
len = length(euclideanDistances);
for ii = 1:len
    eDist = euclideanDistances(ii,firstPassFilter);
    result = 1 - (eDist/maxDist);
    similarityValues(ii,firstPassFilter) = result;
end

%%% SECOND PASS SORTING AND FILTERING

% sort by euclidean distance of second pass filter, most similar images first
[euclideanDistances, sortedIndexes] = sortrows(euclideanDistances,secondPassFilter);

% sorting fileNames and similarityValues arrays accordingly 
len = length(euclideanDistances);
newFileNames = {};
newSimilarityValues = zeros(len, 3);
for ii = 1:len
    newFileNames = [newFileNames; fileNames(sortedIndexes(ii,1),1)];
    % rearranging all 3 columns
    newSimilarityValues(ii,1) = similarityValues(sortedIndexes(ii,1),1);
    newSimilarityValues(ii,2) = similarityValues(sortedIndexes(ii,1),2);
    newSimilarityValues(ii,3) = similarityValues(sortedIndexes(ii,1),3);
end
fileNames = newFileNames;
similarityValues = newSimilarityValues;
secondPassFileNames = fileNames;

% getting highest EuclideanDist value as the benchmark for 0% similarity
% a Euclidean Distance of 0 will be considered 100% similarity
maxDist = euclideanDistances(length(euclideanDistances), secondPassFilter);

% Computing similarity values for second filter pass
len = length(euclideanDistances);
for ii = 1:len
    eDist = euclideanDistances(ii,secondPassFilter);
    result = 1 - (eDist/maxDist);
    similarityValues(ii,secondPassFilter) = result;
end

return;

close all;