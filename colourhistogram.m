function HSVhist = colourhistogram(I)

[rows, cols, numOfBands] = size(I);

%double checking the pixels of images;
% PixelsOfImage = rows*cols*numOfBands;
% disp(PixelsOfImage);

image = rgb2hsv(I);
figure, imshow(image);

%Split it tinto three of the HSV
hueI = image(:,:,1);
saturI = image(:,:,2);
valueI = image(:,:,3);
%figure;
%subplot(2,2,1);
%figure, imshow(hueI);
%figure, imshow(saturI);
%figure, imshow(valueI);

%equalization of the V value
new_valueI = histeq(valueI);
% figure, imhist(I);

%quantizing each of the HSV
%USing 16x4x4
HSVhist = zeros(16,4,4);

%index column
% index = zeros(rows*cols, 3);

%find the max pixel of the each component
maxH = max(hueI(:));
maxS = max(saturI(:));
maxV = max(new_valueI(:));

%put the pixels according to the bins
% count = 1;
% for row = 1: rows
%     for col = 1: cols
%         hueBins(row,col) = floor(15.9999 * hueI(row, col)/maxH);
%         saturBins(row,col) = floor(3.9999 * saturI(row,col)/maxS);
%         valBins(row,col) = floor(3.9999 * new_valueI(row,col)/maxV);
%
%         index(count,1) = hueBins(row,col);
%         index(count,2) = saturBins(row,col);
%         index(count,3) = valBins(row,col);
%         count = count + 1;
%     end
% end

for row = 1 : rows
    for col = 1 : cols
        hueBin = floor(hueI(row,col)/maxH * 15.9999)+ 1;
        saturBin = floor(saturI(row,col)/maxS * 3.9999)+ 1;
        valBin = floor(new_valueI(row,col)/maxV * 3.9999)+ 1;
        HSVhist(hueBin, saturBin, valBin) = HSVhist(hueBin, saturBin, valBin) + 1;
    end
end

%put the values we got into the matrix
% for row = 1: size(index,1)
%     if(index(row,1) == 0 || index(row,2) == 0 || index(row,3) == 0)
%         continue;
%     end
%     HSVhist(index(row,1), index(row,2), index(row,3)) = ...
%         HSVhist(index(row,1), index(row,2), index(row,3)) + 1;
% end

%normalize the histogram and return an 1x256 feature vector
HSVhist = HSVhist(:);
%HSVhist = HSVhist/sum(HSVhist);

% disp(HSVhist);
% clear;
end
