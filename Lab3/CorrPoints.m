function [Xt Xi ] = CorrPoints(Imt, Imi)
%CORRPOINTS finds corresponding harris points in two images

pt          = IntrestPoints(Imt)
pi          = IntrestPoints(Imi)

[It Jt]     = ind2sub(size(Imt),pt)
[Ii Ji]     = ind2sub(size(Imi),pi)

figure
show_harris(Imt,Imi,[Jt';It'],[Ji'; Ii']);

A           = FindClose(It,Jt,Ii,Ji,30);

rt          = cut_out_rois(Imt,It,Jt);
ri          = cut_out_rois(Imi,Ii,Ji);

[Xt Xi]     = CorrConv(A,rt,ri,It,Jt,Ii,Ji,10);
end