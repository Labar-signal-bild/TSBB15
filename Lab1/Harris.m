function [ Im_intrest ] = Harris( Im )
%HARRIS Uses the Harris operator to determine how intresting pixels are


K = 0.1;
[T11 T22 T12] = HarrisTensor(Im);

cHarris = (T11.*T22-T12.^2) - k*(T11+T22).^2; % The Harris response in each pixel

end


