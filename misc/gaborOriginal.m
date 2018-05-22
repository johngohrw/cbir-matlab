% found from 'matlab gabor filtering an image'
% https://www.youtube.com/watch?v=6PONkBwALDM


%Read the original RCB inputimage
image=imread('Best_Friends.jpg'); 
%convert it to gray scale 
image_gray=rgb2gray(image); 
%resize the image to 160x160 pixels 
image_resize=imresize(image_gray, [270 480]); 
%apply im2double 
image_resize=im2double(image_resize); 
%show the image 
figure(1); 
imshow(image_resize); 
title('Input Image'); 

%Gabor filter size 7x7 and orientation 90 degree 
%declare the variables 
gamma=0.3;  %aspect ratio 
psi=0; %phase 
theta=90; %orientation 
bw=2.8; %bandwidth or effective width 
lambda=3.5; %wave1ength 
pi=180; 
    
for x=1:270 
    for y=1:480
            
        x_theta=image_resize(x,y)*cos(theta)+image_resize(x,y)*sin(theta); 
        y_theta=image_resize(x,y)*sin(theta)+image_resize(x,y)*cos(theta); 
            
        gb(x,y)=exp(-(x_theta.^2/2*bw^2+ gamma^2*y_theta.^2/2*bw^2))*cos(2*pi/lambda*x_theta+psi); 
    end
end
    
figure(2); 
imshow(gb); 
