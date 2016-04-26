%% TSBB15 Diffusion
%cd ~/Documents/TSBB15/Lab4 %Fredrik
cd ~/skola/TSBB15/Lab4 %Poole
clear
initcourse TSBB15
clc
close all
%% Variables
IMAGE_SET = 2; % 1 = camera_man, 2 = testCircle
PLOTS_ON = 1;
k = 10^-2; %10^-2 good for binary
delta_s = 0.3; %Arbitrary scaling factor, 0.3 is a good number for binary
epochs = 100; 


switch IMAGE_SET
    case 1
        std = 30;
        
        im = double(imread('cameraman.tif'));
        
        [L noise_var] = AddNoise(im,'gauss',0,std);
    case 2
        std = 0.1;
        mean_ = 0.5;
        
        [x,y] = meshgrid(-1:.01:1);
        im = (x.^2 + y.^2) < mean_;
        
        [L noise_var] = AddNoise(im,'circle',mean_,std);
    case 3
        std1 = 15;
        std2 = 30;
        std3 = 45;
        im = double(imread('cameraman.tif'));
        
        L1 = AddNoise(im,'gauss',0,std1);
        L2 = AddNoise(im,'gauss',0,std2);
        L3 = AddNoise(im,'gauss',0,std3);

        L1new = AnisotropicDiffusion(L1,k,epochs,delta_s);
        L2new = AnisotropicDiffusion(L2,k,epochs,delta_s);
        L3new = AnisotropicDiffusion(L3,k,epochs,delta_s);
end

if(~(IMAGE_SET == 3))    
    Lnew = AnisotropicDiffusion(L,k,epochs,delta_s);
end

%% Plots

if(~(IMAGE_SET == 3) & PLOTS_ON)
    snr = RestorationPlot(im,L,Lnew,L-Lnew,noise_var,epochs,IMAGE_SET)
elseif(PLOTS_ON)
    snr = RestorationPlot(im,L1new,L2new,L3new,noise_var,epochs,IMAGE_SET)
end


