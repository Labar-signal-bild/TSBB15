function [ Im_intrest ] = Harris( Im )
%HARRIS Uses the Harris operator to determine how intresting pixels are

k = 0.1;
[T11 T22 T12] = HarrisTensor(Im); % Get the low-pass filtered T11-T22

cHarris = (T11.*T22-T12.^2) - k*(T11+T22).^2; % The Harris response in each pixel

histo = hist(cHarris);
figure(10); stem(histo);

histVec = sum(histo,2);
tresh = find(histVec == max(histVec))
tresh = 230000;


cHarrisNew = cHarris>tresh;
maxv2 = max(max(abs(cHarrisNew)))/2;
figure(21)
colormap(gray(256))
imagesc(cHarrisNew, [-maxv2 maxv2]); colorbar('horizontal'); 
axis image; axis off;
title('cHarrisNew')
size(cHarrisNew)
size(Im)


RegMax = imregionalmax(cHarris, 4);
figure(23)
colormap(gray(256))
imagesc(RegMax, [0 maxv2]); colorbar('horizontal'); 
axis image; axis off;
title('cHarrisNew')


HarrisPoints = cHarrisNew.*RegMax;

cornerpoints = find(HarrisPoints == 1); %Ger en vector med pixlar på alla vita corners

cornerpointx = zeros(length(cornerpoints), 1);
cornerpointy = zeros(length(cornerpoints), 1);

for i = 1:length(cornerpoints) %Gör om pixlar till x,y koordinater
    cornerpointx(i) = floor(cornerpoints(i)/size(RegMax,1))+1;
    cornerpointy(i) = cornerpoints(i) - floor(cornerpoints(i)/size(RegMax,2))*size(RegMax,2);
end

cornerpointx = ceil(cornerpointx/size(RegMax,1)*size(Im,1));
cornerpointy = ceil(cornerpointy/size(RegMax,2)*size(Im,2));


r = ones(length(cornerpointx), 1)*3;

figure(22)
colormap(gray(256))
imagesc(HarrisPoints, [0 1]); colorbar('horizontal');
hold on;
%viscircles([cornerpointx cornerpointy], r ,'EdgeColor', 'r');
%axis image; axis off;
title('f_x')



figure(30); imagesc(Im); colormap(gray(256))
figure(30);hold('on');%plot(cornerpointx,cornerpointy, 'go')
viscircles([cornerpointx cornerpointy], r ,'EdgeColor', 'r');


Im_intrest = HarrisPoints;













end


