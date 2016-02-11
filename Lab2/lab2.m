%% Lab2 TSBB15
%clear;
%initcourse TSBB15;
disp('------ Lab2 TSBB15 ------\n')
%%

I = double(imread('forwardL/forwardL0.png'));
J = double(imread('forwardL/forwardL5.png'));

figure(1); imagesc(I); colormap(gray(256))
figure(2); imagesc(J); colormap(gray(256))

%%
%take grad of J
%pass along down into LK_e
filter_size = 8;
stdGrad = 2;
gradParam = [filter_size;stdGrad];
regSize = 20;
V = LkEquation( I,J,gradParam,regSize);

%%
%figure(3);
%gopimage(V)

%figure(4);
%quiver(V(:,:,1), V(:,:,2),1:480,1:512);