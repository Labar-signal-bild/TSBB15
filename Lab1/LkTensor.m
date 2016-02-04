function [ Z ] = LkTensor( Im_reg ,grad_param)
%LKTENSOR Estimate a tensor for a specific region
%[ fx fy] = LkGrad(Im,filter_size,Im_std)

lengthx = 1:size(Im_reg,1);
lengthy= 1:size(Im_reg,2);
%Decide filter size depending on image size (place in triangle)
[fx fy] = LkGrad (Im_reg,grad_param(1),grad_param(2));

Z = [mean(mean(fx.*fx)) mean(mean(fx.*fy)) ; ...
    mean(mean(fx.*fy)) mean(mean(fy.*fy))];

end

