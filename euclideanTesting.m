img1 = imread('images/image1.jpg');
img2 = imread('images/image2.jpg');

% images are resized before any form of processing
% desired resolution of the resized image
resolution = [320; 320];

img1 = imresize(img1,[resolution(1,:) resolution(2,:)]);
img2 = imresize(img2,[resolution(1,:) resolution(2,:)]);

hsvHist1 = colourhistogram(img1);
hsvHist2 = colourhistogram(img2);

colorDist = euclideanDistance(hsvHist1, hsvHist2);

subplot(1,2,1), imshow(img1);
subplot(1,2,2), imshow(img2);
title(colorDist);