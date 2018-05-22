function image_names = filteringSimilarity(euclidean_distance, image_names, threshold)
    new_threshold = 1 - threshold;
    
    max_ED = euclidean_distance(end);
    
    %getting the new dataset for the images, according to the threshold
    new_valueData = max_ED * new_threshold;
    
    for i = 1: length(euclidean_distance)
        if euclidean_distance(1,i) > new_valueData
            euclidean_distance(1,i) = [];
        end
    end
    
    length_filenames = length(euclidean_distance);
    image_names(length_filenames:end-1, :) = [];

    
        