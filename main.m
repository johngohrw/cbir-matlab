I = imread('images/image1.jpg');

% Gabor filter
% arguments:
% Image, Gamma(aspect ratio), Psi(phase), 
% .Theta(orientation), Bandwidth, Lambda(wavelength), Pi
g = gabor(I, 1, 0.1, 90, 2.8, 3.5, 180);

imshow(g)
