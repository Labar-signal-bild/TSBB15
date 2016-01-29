function [ Int_Im ] = LkInterpol(Im,du,method)
%LKINTERPOL Returns value from interpolation interval
Imy = size(Im,1);
Imx = size(Im,2);
upsample_size = 1/du;
Int_Im = zeros(size(Im));
Int = interp2(Im,upsample_size)

for yit = 1:Imy
    for xit = 1:Imx
        
        Int_Im(yit,xit) = Int(xit*upsample_size,yit*upsample_size)
        
        %Vilket värde ska vi hämta ut när vi läser mellan...?
    end
end

end