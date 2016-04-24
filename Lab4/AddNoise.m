function [ Im_noise noise_var] = AddNoise(Im,noise_type, mean, std)
%ADDNOISE Im_noise = AddNoise(image,noise_type, vars)
%Adds noise depending on nois type. 
%The different noise types are:
%
%gauss - Adds gaussian noise to every pixel.
%
%conv - Convolvs gaussian noise onto every pixel.

[N M] = size(Im);

if(strcmp('gauss',noise_type))
    noise = std*randn(N,M)
    noise_var = var(noise(:));
    Im_noise = Im + mean + noise;
elseif(strcmp('conv',noise_type))
    N = 3;
    lp = exp(-0.5*([-N:N]/std).^2);
    lp = lp/sum(lp);
    Im_noise = conv2(lp,lp',Im,'same');
else
    disp(' Can not add this noise, type help AddNoise.')
end
end

