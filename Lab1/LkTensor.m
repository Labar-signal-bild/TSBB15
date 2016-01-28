function [ T ] = LkTensor( Im_reg )
%LKTENSOR Estimate a tensor for a specific region
%[ fx fy] = LkGrad(Im,filter_size,Im_std)

lengthy = 1:size(Im_reg,1);
lengthx= 1:size(Im_reg,2);
Im_std = mean(std(double(Im_reg)));
%Decide filter size depending on image size (place in triangle)
filter_size = ceil(length(Im_reg)/1000);
[fx fy] = LkGrad (Im_reg,filter_size,Im_std);
T  = zeros(2,2);
for y = lengthy
    for x = lengthx
        T = T+[ fx(x,y).^2, fx(x,y) .* fy(x,y)  ; ...
                fx(x,y) .* fy(x,y)  ,fy(x,y).^2   ]; 
    end
    
end
1
end

