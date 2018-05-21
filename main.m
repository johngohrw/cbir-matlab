
% gabor filter arguments
gamma = 1;
psi = 0.1;
theta = 90;
bw = 2.8;
lambda = 3.5; 
pi = 180;

image1 = imread('image1.jpg');
gabor1 = myGabor(image1, gamma, psi, theta, bw, lambda, pi);
gaborMean1 = mean(gabor1);
gaborStd1 = std(gabor1);

image2 = imread('image2.jpg');
gabor2 = myGabor(image2, gamma, psi, theta, bw, lambda, pi);
gaborMean2 = mean(gabor2);
gaborStd2 = std(gabor2);