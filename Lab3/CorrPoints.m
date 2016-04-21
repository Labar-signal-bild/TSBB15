function [corr_t, corr_i] = CorrPoints(Imt, Imi,supBox,cutBox,fsz,std_g,threshold,interest_thresh,harrisPlot)
%SUMMARY CORRPOINTS finds corresponding harris points in two images
% fsz and std_g are parameters for harris.m
% supBox = is the region size from which we find our maximal harris point
% point
% threshold = how good a region intensity must be for intresst points to be
% corresponding
% harrisPlot decides if we plot intrest points

pt = IntrestPoints(Imt,fsz,std_g,supBox,interest_thresh); % position of intrespoints
pi = IntrestPoints(Imi,fsz,std_g,supBox,interest_thresh);


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

rt = cut_out_rois(Imt,colzt,rowzt,cutBox);
ri = cut_out_rois(Imi,colzi,rowzi,cutBox);

[indt, indi] = MeanIntensity(rt,ri,Ipt,Ipi,threshold);

corr_i = Ipi(:,indi);
corr_t = Ipt(:,indt);
end