% euclideanDistance:
% calculates the one-dimensional Euclidean distance for two feature
% vectors. Inputs of the features must be a column vector (col x 1)

function result = euclideanDistance(feature1, feature2)

    % Euclidean distance for comparing the feature vector
    score_euclidean = sqrt(sum((feature1-feature2).^2));
    
    result = score_euclidean;
end

%     %Set a threshold for euclidean similarity where smaller is more similar
%     euclidean_threshold = ;
%     disp('Euclidean Compare')
%     disp(score_euclidean)
%     if score_euclidean < euclidean_threshold
%         disp('similar images');
%         result = 'similar';
%     else
%         disp('dissimilar images');
%         result = 'dissimilar';
%     end