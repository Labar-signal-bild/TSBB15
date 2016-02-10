function [e] = LkDiff( Im1, Im2,grad_param )
%LKDIFF Estimates the image difference e for an image region
if size(Im1) ~= size(Im2)
    disp('---- Error diffrent sized images ----');
    e = 0;
else
    [Im2_gradx Im2_grady lp] = LkGrad(Im2,grad_param(1) ,grad_param(2));
    
    Im1_smooth = conv2(lp,lp',Im1,'same');
    Im2_smooth = conv2(lp,lp',Im2,'same');
    
    e = [mean(mean((Im1_smooth-Im2_smooth).*Im2_gradx)); ...
         mean(mean((Im1_smooth-Im2_smooth).*Im2_grady))];
         
end

end

