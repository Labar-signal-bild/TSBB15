function [ L noise_var] = AddNoise(im,noise_type, mean_, std)
%ADDNOISE Im_noise = AddNoise(image,noise_type, vars)
%Adds noise depending on nois type. 
%The different noise types are:
%
%gauss - Adds gaussian noise to every pixel.
%
%conv - Convolvs gaussian noise onto every pixel.

[N M] = size(im);

if(strcmp('gauss',noise_type))
    noise = std*randn(N,M);
    noise_var = var(noise(:));
    L = im + mean_ + noise;
elseif(strcmp('conv',noise_type))
    N = 3;
    lp = exp(-0.5*([-N:N]/std).^2);
    lp = lp/sum(lp);
    L = conv2(lp,lp',im,'same');
elseif(strcmp('mask',noise_type))
    reg_size = std; %Size of broken region
    reg_number = randi(100); %Random amount of broken region
    %Random positions - remove reg_size to prevent index error.
    reg_position_x = randi(length(im) - reg_size,1,reg_number);
    reg_position_y = randi(length(im) - reg_size,1,reg_number);
     
    L = ones(size(im));
    
    for i = 1:reg_number
        
    L(reg_position_x(i):reg_position_x(i)+reg_size, reg_position_y(i):reg_position_y(i)+reg_size) = 0; 
    
    end
    
    noise_var = 0;
elseif(strcmp('circle',noise_type))
        noise = (rand(size(im))-mean_)*std;
        L = im + noise;
        noise_var = var(noise(:));
else
    disp(' Can not add this noise, type help AddNoise.')
end
end

