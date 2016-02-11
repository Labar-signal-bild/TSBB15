function [ V] = LkEquationMultiscale(I,J,gradParam,regSize,smallestScale,medianfiltersize)
%LKEQUATIONMULTISCALE Take images and calculates V for a scalepyramid
scaleL = 1; %iterative variable


% create scale pyramids
ScaleP_I{1} = I;
ScaleP_J{1} = J;
ImageSize{1} = size(I);

% Scale pyramid - unnecessary
while size(ScaleP_I{scaleL},1) > smallestScale
   scaleL = scaleL+1;
   ScaleP_I{scaleL} = imresize(ScaleP_I{scaleL-1}, 0.5);
   ScaleP_J{scaleL} = imresize(ScaleP_J{scaleL-1}, 0.5);
   ImageSize{scaleL} = size(ScaleP_J{scaleL});
end

V = zeros(ImageSize{scaleL}(1),ImageSize{scaleL}(2),2);
for i=scaleL:-1:1
        newGradParam = gradParam;
        newRegSize = regSize/i;
        newGradParam(3) = newRegSize/3;
        
        Jmoved = LkInterpol(ScaleP_J{i},V,'move');
        
        Vtemp = LkEquation(ScaleP_I{i},Jmoved,newGradParam,newRegSize);
        Vtemp(:,:,1) = medfilt2(Vtemp(:,:,1),[medianfiltersize,medianfiltersize]);
        Vtemp(:,:,2) = medfilt2(Vtemp(:,:,2),[medianfiltersize,medianfiltersize]);
        V = Vtemp+V;
        
        %Upsampling V for next iteration
        if i == 1
            break
        end
        Vnew = zeros(ImageSize{i-1}(1),ImageSize{i-1}(2),2);
        
        Vnew(:,:,1) = imresize(V(:,:,1), size(Vnew(:,:,1)), 'cubic');
        Vnew(:,:,2) = imresize(V(:,:,2), size(Vnew(:,:,2)), 'cubic');
        
        V = Vnew;
end
end

