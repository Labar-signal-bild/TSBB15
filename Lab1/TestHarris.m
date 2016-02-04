%% Test the Harris function
close all;
clear;
Im = double(imread('chessboard_3.png'));

size(Im)

figure(1)
colormap(gray(256))
subplot(1,1,1); imagesc(Im, [0 256]); colorbar;
axis image; axis off;



gshgd = Harris(Im);


