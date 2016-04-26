%% TSBB15 Diffusion
cd ~/Documents/TSBB15/Lab4 %Fredrik
%cd ~/skola/TSBB15/Lab4 %Poole
clear
initcourse TSBB15
clc
close all
%% Variables
IMAGE_SET = 4; % 1 = camera_man, 2 = testCircle,3 = diffrent noise strength
PLOTS_ON = 1;
k = .3;%3 = IMAGE_SET 1,3; %0.0050 IMAGE_SET 2;
delta_s = 0.2; %Arbitrary scaling factor, 0.3 is a good number for binary
epochs = 1000; 


switch IMAGE_SET
    case 1
        std = 10;
        
        im = double(imread('cameraman.tif'));
        
        [L noise_var] = AddNoise(im,'gauss',0,std);
    case 2
        std = 0.1;
        mean_ = 0.5;
        
        [x,y] = meshgrid(-1:.01:1);
        im = (x.^2 + y.^2) < mean_;
        
        [L noise_var] = AddNoise(im,'circle',mean_,std);
    case 3
        std1 = 10;epochs1 = 100;
        std2 = 15;epochs2 = 800;
        std3 = 20;epochs3 = 1600;
        im = double(imread('cameraman.tif'));
        
        L1 = AddNoise(im,'gauss',0,std1);
        L2 = AddNoise(im,'gauss',0,std2);
        L3 = AddNoise(im,'gauss',0,std3);

        L1new = AnisotropicDiffusion(im,L1,k,epochs1,delta_s);
        L2new = AnisotropicDiffusion(im,L2,k,epochs2,delta_s);
        L3new = AnisotropicDiffusion(im,L3,k,epochs3,delta_s);
    case 4
        std = 0.01;
        
        im = double(imread('cameraman.tif'));
        
        L = imnoise(im/255,'speckle',std)*255;
end

if(~(IMAGE_SET == 3))    
    [Lnew sigvar] = AnisotropicDiffusion(im,L,k,epochs,delta_s);
end

% Plots
snr = sigvar./ std^2;

if(~(IMAGE_SET == 3) & PLOTS_ON)
    RestorationPlot(im,L,Lnew,snr,noise_var,epochs,IMAGE_SET);
elseif(PLOTS_ON)
    RestorationPlot(im,L1new,L2new,L3new,noise_var,epochs,IMAGE_SET);
end


