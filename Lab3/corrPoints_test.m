%% Lab3 TSBB15
%cd ~/skola/TSBB15/Lab3
initcourse tsbb15
mex non_max_suppression.c
%% Testing CorrPoints
close all
% Variables
supBox = 10; % Area for finding best harris point
regBox = 100; % Area for finding close intrest points
cutBox = 7; % Area round intrest point
threshold = 10000;
harrisPlot = 1;
fsz = 10;
std_g = 1;
%
%

Imt = imread('DCMI/img1.png');
Imi = imread('DCMI/img2.png');
Imt1 = rgb2gray(Imt);
%Imi1 = Imi(:,:,1);
Imi1 = rgb2gray(Imi);

 [Xt Xi corr_t, corr_i] = CorrPoints(Imt1,Imi1,supBox,regBox,cutBox,fsz,std_g,threshold,harrisPlot);
%show_corresp(Imt1,Imi1,Xt(1:2,:),Xi(1:2,:))
figure;colormap('gray');show_corresp(Imt1,Imi1,corr_t,corr_i)

