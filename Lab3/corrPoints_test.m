%% Lab3 TSBB15
cd ~/skola/TSBB15/Lab3
initcourse tsbb15
mex non_max_suppression.c
%% Testing CorrPoints
close all
%

Imt         = imread('DCMI/stereo-corridor_l.gif');
Imi         = imread('DCMI/stereo-corridor_r.gif');

%[Xt Xi]     = CorrPoints(Imt,Imi);

%show_corresp(Imt,Imi,Xt(1:2,1),Xi(1:2,1));

pt          = IntrestPoints(Imt)
pi          = IntrestPoints(Imi)

[It Jt]     = ind2sub(size(Imt),pt);
[Ii Ji]     = ind2sub(size(Imi),pi);

figure
show_harris(Imt,It,Jt)

A           = FindClose(It,Jt,Ii,Ji,30);

rt          = cut_out_rois(Imt,It,Jt);
ri          = cut_out_rois(Imi,Ii,Ji);

[Xt Xi]     = CorrConv(A,rt,ri,It,Jt,Ii,Ji,10);