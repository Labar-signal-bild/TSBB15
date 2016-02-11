%test.m
%initcourse('TSBB15')
%% Scale pyramid



%[I J dTrue] = getCameraman();
%I = double(imread('forwardL/forwardL0.png'));
I = double(rgb2gray(imread('SCcar4/SCcar4_00070.bmp')));
%J = double(imread('forwardL/forwardL9.png'));
J = double(rgb2gray(imread('SCcar4/SCcar4_00071.bmp')));

figure(1); imagesc(I); colormap(gray(256));
figure(2); imagesc(J); colormap(gray(256));

smallestScale = 100;
filterSize = 8; %Gradient filter size
stdGrad = 2; %Gradient median
stdLp = 7; %Gaussian for convolving
regSize =21; %Size of gaussian filter
gradParam = [filterSize;stdGrad;stdLp];

Vtemp = LkEquationMultiscale(I,J,gradParam,regSize,smallestScale,1);

%%
figure(3);
gopimage(Vtemp); axis image;caxis([0 0.1]);
%How do we rescale?!