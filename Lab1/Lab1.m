%% Lab1 main file
disp('------ Lab 1 LK-Tracker ------');
%initcourse('TSBB15');
%% Main program

scale_levels = 1; %iterative variable
smallest_scale = 10; %pixels of smallest image in scale pyramid 

Im1 = 1
Im2 = 2

% load images
Im_temp = 0;

[Im1 Im2 dTrue] = getCameraman();

figure(1)
subplot(1,2,1)
imagesc(Im1);colormap(gray);
subplot(1,2,2)
imagesc(Im2);colormap(gray);

% create scale pyramids
ScalePyramid_Im1{1} = Im1;
ScalePyramid_Im2{1} = Im2;


%%
while size(ScalePyramid_Im1{scale_levels},1) > smallest_scale
   scale_levels = scale_levels+1
   ScalePyramid_Im1{scale_levels} = imresize(ScalePyramid_Im1{scale_levels-1}, 0.5);
   ScalePyramid_Im2{scale_levels} = imresize(ScalePyramid_Im2{scale_levels-1}, 0.5);
end

figure(2)
for j=1:scale_levels
subplot(2,scale_levels,j)
imagesc(ScalePyramid_Im1{j});colormap(gray);
subplot(2,scale_levels,j+scale_levels)
imagesc(ScalePyramid_Im2{j});colormap(gray);
end
%% LkTracking
% Upsamle and recompute LkTracker untill original size achived

d = LkTracker(ScalePyramid_Im1{i},ScalePyramid_Im2{i},d);
%%
d = 0
for i = scale_levels:-1:1 %Start from the smallest pyramid
% Use LkTracker to compute optimal displacement
d = LkTracker(ScalePyramid_Im1{i},ScalePyramid_Im2{i},d);
end





