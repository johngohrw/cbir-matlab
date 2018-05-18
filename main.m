I = imread('images/image60.jpg');

% Gabor filter
% arguments:
% Image,  Gamma,         Psi,    Theta,        Bandwidth,  Lambda,      Pi
% Image, (aspect ratio),(phase),(orientation),(bandwidth),(wavelength),(pi)
g = myGabor(I, 1, 0.1, 90, 2.8, 3.5, 180);

imshow(g)
whos g