function image = uploadQueryImage 
    [filename, pathname] = uigetfile({'*.jpg;*.png;*.gif;*.bmp', 'All Image Files (*.jpg, *.png, *.gif, *.bmp)'; ...
                '*.*',                   'All Files (*.*)'}, ...
                'Pick an image file', 'MultiSelect', 'on');
     image = imread([pathname,filename]);
     
     imshow(image, 'Parent', app.UIAxes);