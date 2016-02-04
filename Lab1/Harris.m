function [ Im_intrest ] = Harris( Im )
%HARRIS Uses the Harris operator to determine how intresting pixels are

k = 0.1;
[T11 T22 T12] = HarrisTensor(Im); % Get the low-pass filtered T11-T22

cHarris = (T11.*T22-T12.^2) - k*(T11+T22).^2; % The Harris response in each pixel

histo = hist(cHarris);


histVec = sum(histo,2);
tresh = find(histVec == max(histVec));
tresh = (tresh-0.5)*sum(histVec);



cHarrisNew = cHarris>tresh;
maxv2 = max(max(abs(cHarrisNew)))/2;

RegMax = imregionalmax(cHarris, 4);

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


Im_intrest = [cornerpointx cornerpointy];

end


