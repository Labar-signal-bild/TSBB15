function [Xt Xi ] = CorrPoints(Imt, Imi,supBox,regBox,threshold,harrisPlot)
%SUMMARY CORRPOINTS finds corresponding harris points in two images
% fsz and std_g are parameters for harris.m
% supBox = is the region size from which we find our maximal harris point
% regBox = is the region size from which we search for corresponding intresst
% point
% threshold = how good a region intensity must be for intresst points to be
% corresponding
% harrisPlot decides if we plot intrest points

% Variables
fsz = 20;
std_g = 1;
%

pt = IntrestPoints(Imt,fsz,std_g,supBox); % position of intrespoints
pi = IntrestPoints(Imi,fsz,std_g,supBox);


[rowzt colzt]     = ind2sub(size(Imt),pt);
[rowzi colzi]     = ind2sub(size(Imi),pi);


if(harrisPlot)
    figure
    subplot(2,1,1)
    show_harris(Imt,colzt,rowzt);
    subplot(2,1,2)
    show_harris(Imi,colzi,rowzi);
end

A  = FindClose(colzt,rowzt,colzi,rowzi,regBox);

rt = cut_out_rois(Imt,colzt,rowzt);
ri = cut_out_rois(Imi,colzi,rowzi);

[Xt Xi] = MeanIntensity(A,rt,ri,colzt,rowzt,colzi,rowzi,threshold);
end