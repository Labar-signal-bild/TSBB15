%% TSBB15 lab4
%cd ~/Documents/TSBB15/Lab4 %Fredrik
cd ~/skola/TSBB15/Lab4 %Poole
clear
initcourse TSBB15
clc
close all
%% Variables
IMAGE_SET = 1; % 1 = camera_man, 2 = testCircle

switch IMAGE_SET
    case 1
        std = 30;
        im = double(imread('cameraman.tif'));
        [L noise_var] = AddNoise(im,'gauss',0,std);
    case 2
        std = 0.1;
        mean_ = 0.5;
        % create test image for the restoration lab
        [x,y] = meshgrid(-1:.01:1);
        im = (x.^2 + y.^2) < mean_;
        noise = (rand(size(im))-mean_)*std;
        L = im + noise;
        noise_var = var(noise(:));
        % use same color axis in all images
        colorAxis = [min(im(:))-.1 max(im(:))+.1];

        figure(1);
        imagesc(im, colorAxis); colorbar;
        title('Image with noise');
otherwise

end

%% Anisotropic diffusion algorithm
k = 10^-2; %10^-2 good for binary
delta_s = 0.3; %Arbitrary scaling factor, 0.3 is a good number for binary
iterations = 100;
%L = +im; %If looking at binary image to cast from logical to double
Lnew = L;

tic
for epochs = 1:iterations
    
    DHL_trace = DHLTrace(L,k);
    Lnew = Lnew + delta_s * DHL_trace;
end
toc

%% Plots

Lnew_mean = mean(mean(Lnew));
L_mean = mean(mean(L));
meanim = mean(mean(im));

figure(2);clf;
subplot(1,2,1);imshow(im,[]);title(['Without noise, mean = ' num2str(meanim)]);
subplot(1,2,2);imshow(L,[]);title(['With noise, std = ' num2str(std)]);

%imshow(im,[0 1]) if we have a binary image with many epochs
figure(3);clf; 
subplot(2,2,1);imshow(im,[]);title(['Original image ' num2str(meanim)]);
subplot(2,2,2);imshow(L,[]);title(['With noise, mean = ' num2str(L_mean)]);
subplot(2,2,3);imshow(Lnew,[]);title(['Enhancement after '...
                      num2str(epochs) ' epochs, mean = ' num2str(Lnew_mean) ]);
subplot(2,2,4);imshow(L-Lnew,[]);title(['Difference after ' num2str(epochs) ' epochs']);

%% Calculate SNR
signal_var =  var(Lnew(:));
snr = 10 * log10(signal_var / noise_var)

% What is meant by 1 iteration of diffusion process? 1 iteration of
% everything or just calculating the diffusion tensor once?



%% Inpainting via Total Variation

u = L;
unew = u;

