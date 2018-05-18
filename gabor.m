function gaborResult = gabor(image, gamma, psi, theta, bw, lambda, pi)

    %convert it to gray scale 
    image_gray=rgb2gray(image); 
    %resize the image to 160x160 pixels 
    image_resize=imresize(image_gray, [270 480]); 
    %apply im2double 
    image_resize=im2double(image_resize); 

    %Gabor filter size 7x7 and orientation

    for x=1:270 
        for y=1:480

            x_theta=image_resize(x,y)*cos(theta)+image_resize(x,y)*sin(theta); 
            y_theta=image_resize(x,y)*sin(theta)+image_resize(x,y)*cos(theta); 

            gb(x,y)=exp(-(x_theta.^2/2*bw^2+ gamma^2*y_theta.^2/2*bw^2))*cos(2*pi/lambda*x_theta+psi); 
        end
    end
    
    gaborResult = gb;
end