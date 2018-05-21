%Euclidean distance for comparing the feature vector

% 
% format long g
% clear variables
% G  = rand(1, 72);
% G2 = rand(1, 72);
% D1 = sqrt(sum((G - G2) .^ 2))
% V  = G - G2;
% D2 = sqrt(V * V')
% D3 = norm(G - G2)

feature1 = rand(1, 256);
feature2 = rand(1, 256);

score_euclidean = pdist2(feature1, feature2);

%Set a threshold for euclidean similarity where smaller is more similar
euclidean_threshold = 0.1;
disp('Euclidean Compare')
disp(score_euclidean)
if score_euclidean < euclidean_threshold
    disp('similar images');
else
    disp('dissimilar images');
end