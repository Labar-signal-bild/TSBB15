
%% TSBB15 lab4
%cd ~/Documents/TSBB15/Lab4 %Fredrik
cd ~/skola/TSBB15/Lab4 %Poole
clear
initcourse TSBB15
clc
close all
%% Variables
      reg_size = 0;
        im = double(imread('cameraman.tif'));
        mask = AddNoise(im,'mask',0,reg_size);
figure(1);
imshow(mask)

%% Inpainting via Total Variation

%
lambda = 0.1;
alpha = 0.0005;
it_rater = 100;

g = mask.*im;
u = g;

tic
while(true)
    
    u = g;
    lambda = lambda + 0.1;
    alpha = alpha; %+ 0.00005;
 %if no work do hessian stuff
    for it = 1:it_rater
        
    [ux, uy] = LkGrad(u,3,0.5);
    [uxx, uxy] = LkGrad(ux,3,0.5);
    [uyy, uyx] = LkGrad(uy,3,0.5);

    abs_grad = sqrt(ux.^2 + uy.^2);


    u = u - alpha*(mask.*(u-g) - lambda*(uxx.*uy.^2-2*uxy.*ux.*uy+uyy.*ux.^2)./abs_grad.^3);

    
    end
    
    figure(3)
    imshow(u, [])
    drawnow;
    lambda
    alpha
    k = waitforbuttonpress;
end
toc



%u_new = 
