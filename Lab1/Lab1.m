%% Lab1 main file
clear;
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
    k = waitforbuttonpress 
    
end

%% Using scale pyramids - untested below
scale_levels = 1; %iterative variable
smallest_scale = 10; %pixels of smallest image in scale pyramid 
intrest_point = [85;120];

% load images
Im_temp = 0;

[Im2 Im1 dTrue] = getCameraman();

figure(1);
subplot(1,2,1);
imagesc(Im1);colormap(gray);
subplot(1,2,2);
imagesc(Im2);colormap(gray);

% create scale pyramids
ScalePyramid_Im1{1} = Im1;
ScalePyramid_Im2{1} = Im2;

% Scale pyramid - unnecessary
while size(ScalePyramid_Im1{scale_levels},1) > smallest_scale
   scale_levels = scale_levels+1;
   ScalePyramid_Im1{scale_levels} = imresize(ScalePyramid_Im1{scale_levels-1}, 0.5);
   ScalePyramid_Im2{scale_levels} = imresize(ScalePyramid_Im2{scale_levels-1}, 0.5);
end

figure(2)
for j=1:scale_levels
subplot(2,scale_levels,j);
imagesc(ScalePyramid_Im1{j});colormap(gray);
subplot(2,scale_levels,j+scale_levels);
imagesc(ScalePyramid_Im2{j});colormap(gray);
end
 %Establishing region of intrest with cHarris

HarrisPoints = Harris(ScalePyramid_Im2{1});

% LkTracking
% Upsamle and recompute LkTracker untill original size achived

[dtot e z] = LkTracker(ScalePyramid_Im2{1},ScalePyramid_Im1{1},intrest_point);
%
d = 0;
for i = scale_levels:-1:1 %Start from the smallest pyramid
 Use LkTracker to compute optimal displacement
d = LkTracker(ScalePyramid_Im1{i},ScalePyramid_Im2{i},d);
end


