function [ T11Out T22Out T12Out ] = HarrisTensor( Image )
%HARRISTENSOR Make a tensor for each pixel and put it in a matrix

[fx fy] = LkGrad (Image,3,0.5); % 1/0.5 these you can variate
% Cameraman looks good with these numbers


T11 = fx.^2;
T22 = fy.^2;
T12 = fx.*fy;

sigma = 1.5;
lpH=exp(-0.5*([-9:9]/sigma).^2);
lpH=lpH/sum(lpH);
lpV=lpH';

T11Lp=conv2(T11,lpH,'same');
T11Lp=conv2(T11Lp,lpV,'same');

T22Lp=conv2(T22,lpH,'same');
T22Lp=conv2(T22Lp,lpV,'same');

T12Lp = conv2(T12,lpH,'same');
T12Lp = conv2(T12Lp,lpV,'same');

T11Out = T11Lp;
T22Out = T22Lp;
T12Out = T12Lp;


end

