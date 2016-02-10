function [ Im_intrest ] = Harris( Im , K)
%HARRIS Uses the Harris operator to determine how intresting pixels are


[T11 T22 T12] = HarrisTensor(Im); % Get the low-pass filtered T11-T22

k = 0.1;
cHarris = (T11.*T22-T12.^2) - k*(T11+T22).^2; % The Harris response in each pixel



histo = hist(cHarris);
histVec = sum(histo,2);
tresh = find(histVec == max(histVec));
tresh = (tresh-0.5)*sum(histVec);
%Decide the threshold by taking max of histogram.

cHarrisNew = zeros(size(cHarris,1), size(cHarris,2));
treshPoints = find(cHarris > tresh);
cHarrisNew(treshPoints) = 1;
%Create a mask with all harris points larger than thresh.
cHarrisValues = cHarrisNew.*cHarris;
%Extract all harris values  with points larger than thresh.

RegMax = imregionalmax(cHarris, 4);
%Max value - binary!

HarrisPoints = cHarrisNew.*RegMax;
%Mask with max values that are also harris points
cHarrisValues = cHarrisValues.*HarrisPoints;
%Extract all max harris values

Imm = ordfilt2(cHarrisValues,9,ones(3)); 
Imm(Imm == 0) = NaN;
[row,col] = find(cHarrisValues==Imm);
%All non-zero values should be kept. Zero is not interesting -> NaN.

cHarrisValuesdilated = zeros(1,length(col));
for i = 1:length(col)
cHarrisValuesdilated(i) = cHarrisValues(row(i),col(i));  
end
[Maxval,I] = sort(cHarrisValuesdilated);

rowz = row(I(end-K-1:end))
colz = col(I(end-K-1:end))
Im_intrest = [rowz colz]

%Extract all max harris values that are far away from eachother.

r = ones(length(colz), 1)*3;


figure(30); clf; imagesc(Im); colormap(gray(256))
figure(30);hold('on'); plot(colz,rowz, 'go')
viscircles([colz rowz], r ,'EdgeColor', 'r');




end


