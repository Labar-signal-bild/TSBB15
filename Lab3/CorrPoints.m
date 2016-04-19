function [Xt Xi corr_t, corr_i] = CorrPoints(Imt, Imi,supBox,regBox,cutBox,fsz,std_g,threshold,harrisPlot)
%SUMMARY CORRPOINTS finds corresponding harris points in two images
% fsz and std_g are parameters for harris.m
% supBox = is the region size from which we find our maximal harris point
% regBox = is the region size from which we search for corresponding intresst
% point
% threshold = how good a region intensity must be for intresst points to be
% corresponding
% harrisPlot decides if we plot intrest points

pt = IntrestPoints(Imt,fsz,std_g,supBox); % position of intrespoints
pi = IntrestPoints(Imi,fsz,std_g,supBox);


[rowzt colzt]     = ind2sub(size(Imt),pt);
[rowzi colzi]     = ind2sub(size(Imi),pi);
Ipt = [colzt';rowzt']; %[x;y]
Ipi = [colzi';rowzi'];


if(harrisPlot)
    figure
    subplot(3,1,1)
    show_harris(Imt,colzt,rowzt);
    subplot(3,1,2)
    show_harris(Imi,colzi,rowzi);
    subplot(3,1,3)
end

A  = FindClose(colzt,rowzt,colzi,rowzi,regBox);

rt = cut_out_rois(Imt,colzt,rowzt,cutBox);
ri = cut_out_rois(Imi,colzi,rowzi,cutBox);

[Xt, Xi, indt, indi] = MeanIntensity(A,rt,ri,Ipt,Ipi,threshold, cutBox);

corr_i = Ipi(:,indi);
corr_t = Ipt(:,indt);
end