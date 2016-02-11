%% Lab2 TSBB15
%clear;
%initcourse TSBB15;
disp('------ Lab2 TSBB15 ------')
%%
%[I J dTrue] = getCameraman();
%J = double(imread('forwardL/forwardL0.png'));
J = double(rgb2gray(imread('SCcar4/SCcar4_00070.bmp')));
%I = double(imread('forwardL/forwardL5.png'));
I = double(rgb2gray(imread('SCcar4/SCcar4_00071.bmp')));

figure(1); imagesc(I); colormap(gray(256));
figure(2); imagesc(J); colormap(gray(256));

%%
filterSize = 8; %Gradient filter size
stdGrad = 2; %Gradient median
stdLp = 7; %Gaussian for convolving
regSize =21; %Size of gaussian filter

gradParam = [filterSize;stdGrad;stdLp];
V = LkEquation( I,J,gradParam,regSize);

%%
figure(3);
gopimage(V); axis image;caxis([0 0.1]);
%How do we rescale?!
%%
figure(4);
imshow(V(:,:,1),[]);
figure(5);
imshow(V(:,:,2),[]);

%%
figure(6);
quiver(1000*V(:,:,2),1000*V(:,:,1));
axis([0 size(I,1) 0 size(J,2)]);

%% Calculate the error
ErrX = sqrt(sum(sum((I - J).^2)))
IV = LkInterpol(J,V,'move'); %Because x first, y after.
ErrXv =sqrt(sum(sum((I - IV).^2)))
figure(7);
imshow(IV,[]);







%% MULTI SCALE PART - Scale pyramid
smallestScale = 100;
filterSize = 5; %Gradient filter size
stdGrad = 2; %Gradient median
stdLp = 7; %Gaussian for convolving
regSize =21; %Size of gaussian filter
gradParam = [filterSize;stdGrad;stdLp];

V = LkEquationMultiscale(I,J,gradParam,regSize,smallestScale,5);



 
%%
figure(13);
gopimage(V); axis image;caxis([0 0.1]);
%How do we rescale?!
%%
figure(14);
imshow(V(:,:,1),[]);
figure(15);
imshow(V(:,:,2),[]);

%%
figure(16);
quiver(1000*V(:,:,2),1000*V(:,:,1));
axis([0 size(I,1) 0 size(J,2)]);

%% Calculate the error
ErrX =sqrt(sum(sum((J - I).^2)))
IV = LkInterpol(J,V,'move'); %Because x first, y after.
ErrXv =sqrt(sum(sum((I - IV).^2)))


figure(17);
imshow(IV,[]);