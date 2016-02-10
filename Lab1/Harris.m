function [ Im_intrest ] = Harris( Im , K)
%HARRIS Uses the Harris operator to determine how intresting pixels are


[T11 T22 T12] = HarrisTensor(Im); % Get the low-pass filtered T11-T22

k = 0.1;
cHarris = (T11.*T22-T12.^2) - k*(T11+T22).^2; % The Harris response in each pixel
%figure(2)
%maxv2 = max(max(abs(cHarris)))/2;
%imagesc(cHarris, [-maxv2 maxv2]); colorbar('horizontal'); 
%axis image; axis off;
%title('cHarris')
%size(cHarris)


histo = hist(cHarris);
stem(histo);

histVec = sum(histo,2);
tresh = find(histVec == max(histVec));
tresh = (tresh-0.5)*sum(histVec);


cHarrisNew = zeros(size(cHarris,1), size(cHarris,2));
treshPoints = find(cHarris > tresh);
cHarrisNew(treshPoints) = 1;

cHarrisValues = cHarrisNew.*cHarris;

maxv2 = max(max(abs(cHarrisNew)))/2;
%colormap(gray(256))
%figure(1)
%imagesc(cHarrisNew, [0 maxv2]); colorbar('horizontal'); 
%axis image; axis off;
%title('cHarrisNew')


RegMax = imregionalmax(cHarris, 4);
%figure(23)
%colormap(gray(256))
%imagesc(RegMax, [0 maxv2]); colorbar('horizontal'); 
%axis image; axis off;
%title('regmax')

%figure(1338)
%maxv2 = max(max(abs(cHarrisNew)))/2;
%imagesc(cHarrisNew, [-maxv2 maxv2]); colorbar('horizontal'); 
%axis image; axis off;
%title('cHarrisnew')

HarrisPoints = cHarrisNew.*RegMax;
cHarrisValues = cHarrisValues.*HarrisPoints;

Imm = ordfilt2(cHarrisValues,9,ones(3)); 
[row,col] = find(cHarrisValues==Imm);
%cHarrisValuesdilated = cHarrisValues(row,col);


%figure(1339)

%imagesc(HarrisPoints, [0 1]); colorbar('horizontal'); 
%axis image; axis off;
%title('harris points')
%hpsum = sum(sum(sum(HarrisPoints)))

%HarrisPoints = bwmorph(HarrisPoints,'dilate',5);
%HarrisPoints = bwmorph(HarrisPoints,'shrink',5);


cornerpoints = find(HarrisPoints == 1); %Ger en vector med pixlar på alla vita corners
[x y] = ind2sub(size(Im),cornerpoints);



r = ones(length(x), 1)*3;


%figure(22)
%colormap(gray(256))
%imagesc(HarrisPoints, [0 1]); colorbar('horizontal');
%hold on;
%viscircles([cornerpointx cornerpointy], r ,'EdgeColor', 'r');
%axis image; axis off;
%title('HarrisPoints')

figure(30); imagesc(Im); colormap(gray(256))
figure(30);hold('on'); plot(y,x, 'go')
%viscircles([y x], r ,'EdgeColor', 'r');


Im_intrest = 1;


end


