
%% TSBB15 lab4
cd ~/Documents/TSBB15/Lab4 %Fredrik
%cd ~/skola/TSBB15/Lab4 %Poole
clear
initcourse TSBB15
clc
close all
%% Variables
      reg_size = 3;
        im = double(imread('cameraman.tif'));
        mask = AddNoise(im,'mask',0,reg_size);
%figure(1);
%imshow(mask)

%% Inpainting via Total Variation

%
lambda = 0.5;
alpha = 0.0005;
epochs = 300;

g = mask.*im;
u = g;

tic
    for it = 1:epochs
        %it
    [ux, uy] = LkGrad(u,3,0.5);
    [uxx, uxy] = LkGrad(ux,3,0.5);
    [uyy, uyx] = LkGrad(uy,3,0.5);

    abs_grad = sqrt(ux.^2 + uy.^2);
    u_mask = mask.*(u-g);
    u_div = (uxx.*(uy).^2-2*uxy.*ux.*uy+uyy.*(ux).^2)./(abs_grad).^3;
    u = u - alpha*(u_mask - lambda*u_div);
    end
    toc
    %%
        figure(2)
    subplot(2,2,1)
    imshow(g, [0 255]);title('g')
    subplot(2,2,2)
    imshow(u, [0 255]);title('u')
    subplot(2,2,3)
    imshow(u_mask, []);title('u_{mask}')
    subplot(2,2,4)    
    imshow(u_div, []);title('u_{div}')
    drawnow;
   % k = waitforbuttonpress;
   % end

%% Plot u_mask,u_div,u


%%
    figure(3)
    subplot(2,2,1)
    imshow(g, []);title('g')
    subplot(2,2,2)
    imshow(u_div, []);title('u_{div}')
    subplot(2,2,3)
    imshow(u, [0 253]);title('u')
    subplot(2,2,4)    
    imshow(u_mask, []);title('u_{mask}')
    drawnow;