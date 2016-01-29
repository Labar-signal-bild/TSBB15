function [ T11Lp T22Lp T12Lp ] = HarrisTensor( Image )
%HARRISTENSOR Make a tensor for each pixel and put it in a matrix

TensorMatrix = cell(size(Image));

filter_size = ceil(length(Im_reg)/10);

Im_std = mean(std(double(Im_reg)));
[fx fy] = LkGrad (Im_reg,filter_size,Im_std);

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



end

