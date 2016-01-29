function [e] = LkDiff( Im1, Im2 )
%LKDIFF Estimates the image difference e for an image region
if size(Im1) ~= size(Im2)
    disp('---- Error diffrent sized images ----');
    e = 0;
else
    lengthy = 1:size(Im1,1);
    lengthx= 1:size(Im1,2);
    filter_size = ceil(length(Im2)/10);
    Im_2_std = mean(std(double(Im2)));
    [Im2_gradx Im2_grady] = LkGrad(Im2,filter_size ,Im_2_std);
    e = zeros(2,1);
    for x = lengthx
        for y = lengthy
        e = e + (Im1(x,y)-Im2(x,y))*[Im2_gradx(x,y);Im2_grady(x,y)];
        end
    end
end

end

