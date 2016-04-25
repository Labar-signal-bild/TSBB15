%% TSBB15 lab4
%cd ~/Documents/TSBB15/Lab4 %Fredrik
cd ~/skola/TSBB15/Lab4 %Poole
clear
clc
initcourse TSBB15
close all
%% Variables
IMAGE_SET = 2; % 1 = camera_man, 2 = testCircle

switch IMAGE_SET
    case 1
        std = 10;
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

%% Algorithm 
k = 10^-2;
delta_s = 0.3; %Arbitrary scaling factor 0.3
iterations = 1;

Lnew = L;
L_mean = mean(mean(L));
meanim = mean(mean(im));
figure(2);clf;
subplot(1,2,1);imshow(im,[]);title(['Without noise, mean = ' num2str(meanim)]);
subplot(1,2,2);imshow(L,[]);title(['With noise, std = ' num2str(std)]);

DHL_trace = DHLTrace(L,k);

for epochs = 1:iterations
    Lnew = Lnew + delta_s * DHL_trace;
end

Lnew_mean = mean(mean(Lnew));
figure(3);clf;
subplot(2,2,1);imshow(im,[]);title(['Original image ' num2str(meanim)]);
subplot(2,2,2);imshow(L,[]);title(['With noise, mean = ' num2str(L_mean)]);
subplot(2,2,3);imshow(Lnew,[]);title(['Enhancement after '...
                      num2str(epochs) ' epochs, mean = ' num2str(Lnew_mean) ]);
subplot(2,2,4);imshow(L-Lnew,[]);title(['Difference after ' num2str(epochs) ' epochs']);

signal_var =  var(Lnew(:));
snr = 10 * log10(signal_var / noise_var)

% L = image
%TODO: 
% Find good parameter values!
% - What is s? What is delta s?
% What is meant by 1 iteration of diffusion process? 1 iteration of
% everything or just calculating the diffusion tensor once?
% Try both qualitative and quantitative test.