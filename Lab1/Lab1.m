%% Lab1 main file
clear;
close all;
disp('------ Lab 1 LK-Tracker ------');
initcourse('TSBB15');
%% Main program

Im1 = double(imread('chessboard_1.png'));
HarrisPoints = Harris(Im1, 5);

figure(11); imagesc(Im1); colormap(gray(256))
figure(11); hold on ;plot(HarrisPoints(1:end,2), HarrisPoints(1:end,1), 'go'); hold off

for i = 1:9
    Im1 = double(imread(strcat('chessboard_',num2str(i),'.png')));
    Im2 = double(imread(strcat('chessboard_',num2str(i+1),'.png')));   
    [dtot e z] = LkTracker(Im1,Im2,HarrisPoints);
    HarrisPoints = HarrisPoints + [dtot(:,2) dtot(:,1)];
    figure(i); imagesc(Im2); colormap(gray(256));
    figure(i);  hold on; plot(HarrisPoints(1:end,2), HarrisPoints(1:end,1), 'go'); hold off;
    k = waitforbuttonpress;
    
end
