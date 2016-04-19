%% Lab3 TSBB15
cd ~/skola/TSBB15/Lab3
initcourse tsbb15
mex non_max_suppression.c
%% Testing CorrPoints
close all
% Variables
supBox = 100;
regBox = 50;
threshold = 100;
%

Imt = imread('DCMI/img1.png');
Imi = imread('DCMI/img2.png');
Imt1 = Imt(:,:,1);
Imi1 = Imt(:,:,1);

[Xt Xi] = CorrPoints(Imt1,Imi1,supBox,regBox,threshold);