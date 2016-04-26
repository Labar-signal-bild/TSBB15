
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
mask = AddNoise(im,'mask',0,reg_size-1); %Remove 1 because reason
figure(1);
imshow(mask)

%% Inpainting via Total Variation

%
METHOD = 2;
lambda = 0.15;
alpha = 0.5;
epochs = 2000;
N = 2;
std = 1;

g = mask.*im;
u = g;
error = zeros(1,epochs+1);
error(1) = sum(sum( (im-u).^2));

switch METHOD
    case 1

tic
    for it = 1:epochs
        %it
        [ux, uy] = LkGrad(u,N,std);
        [uxx, uxy] = LkGrad(ux,N,std);
        [uyy, uyx] = LkGrad(uy,N,std);

        abs_grad = sqrt(ux.^2 + uy.^2);
        u_mask = mask.*(u - g);
        u_div = (uxx .* (uy) .^2 - 2 .* uxy .* ux .* uy + ...
                uyy .* (ux) .^2 ) ./ (abs_grad) .^3;
            %LP filter the added intensity
        u = u - alpha .* (u_mask - lambda .* u_div);
        error(it+1) = sum(sum( (im-u).^2));
    end

toc

    case 2
        for it = 1:epochs
        % Calculate structure tensor T with HarrisTensor
        [T11 T22 T12]= HarrisTensor(u,N,std); 

        % Hessian = approx acc to slide 64
        h11 = [0,0,0; 1,-2,1;0,0,0];
        h12 = 1/4*[1,0,-1; 0,0,0;-1,0,1];
        h22 = h11';
        H11 = conv2(u,h11,'same');
        H12 = conv2(u,h12,'same');
        H22 = conv2(u,h22,'same');
    
        abs_grad = sqrt(T11 + T22);
        u_mask = mask.*(u - g);
        
        u_div = (H11 .* T22 - 2 .* H12 .* T12 + ...
                H22 .* T11 ) ./ (abs_grad) .^3;
        %LP filter the added intensity
        u = u - alpha .* (u_mask - lambda .* u_div);
        error(it+1) = sum(sum( (im-u).^2));
        end
        u = u - alpha .* (u_mask );
end

colorAxis = [min(im(:))-.1 max(im(:))+.1];

figure(4)
subplot(2,2,1)
        imagesc(im, colorAxis); colorbar;title('im')
subplot(2,2,2)
        imagesc(g, colorAxis); colorbar;title('g')
subplot(2,2,3)
        imagesc(u, colorAxis); colorbar;title('u')
subplot(2,2,4)    
plot(error);title('error')%'u_{div}')

drawnow;
   % k = waitforbuttonpress;
   % end

%% Plot u_mask,u_div,u


%%
    figure(5)
    subplot(2,2,1)
    imshow(g, []);title('g')
    subplot(2,2,2)
    imshow(u_div, []);title('u_{div}')
    subplot(2,2,3)
    imshow(u, [0 253]);title('u')
    subplot(2,2,4)    
    imshow(u_mask, []);title('u_{mask}')
    drawnow;