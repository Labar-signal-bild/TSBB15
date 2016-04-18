%% Lab3 TSBB15
cd ~/skola/TSBB15/Lab3
initcourse tsbb15
mex non_max_suppression.c
%% Testing CorrPoints
close all
% Variables
fsz = 20;
std_g = 1;
supBox = 100;
%

Imt = imread('DCMI/img1.png');
Imi = imread('DCMI/img2.png');
Imt = Imt(:,:,1);
Imi = Imt(:,:,1);

pt = IntrestPoints(Imt,fsz,std_g,supBox);
pi = IntrestPoints(Imi,fsz,std_g,supBox);


[rowzt colzt]     = ind2sub(size(Imt),pt);
[rowzi colzi]     = ind2sub(size(Imi),pi);

figure
subplot(2,1,1)
show_harris(Imt,colzt,rowzt);
subplot(2,1,2)
show_harris(Imi,colzi,rowzi);

A  = FindClose(colzt,rowzt,colzi,rowzi,300);
%%

rt = cut_out_rois(Imt,colzt,rowzt);
ri = cut_out_rois(Imi,colzi,rowzi);

[Xt Xi] = CorrConv(A,rt,ri,rowzt,colzt,rowzi,colzi,10);