% returns an index value (of a sorted similarityValues array) where
% all similarity values below that index exceeds the given threshold.
% That value can then be used to splice arrays from the back.

% this function assumes the similarityValues array is sorted descendingly.

function detachIndex = filteringSimilarity(similarityValues, filterNumber, threshold)

    % disp(['threshold: ', num2str(threshold)]);

    detachIndex = Inf; % initialized with an exceedingly high value
    
    for ii = 1: length(similarityValues)
        if similarityValues(ii, filterNumber) < threshold
            detachIndex = ii;
            break
        end
    end

end        
