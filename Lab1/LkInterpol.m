function [ Int_Im ] = LkInterpol(Im,du,type,method)
%LKINTERPOL Returns value from interpolation interval
% du contains [dx ,dy]

switch lower(type)
    case{'upsample'}
       
        %We always want to upsample with 2.
        Int_Im = interp2(Im,1,lower(method))
        
    case{'move'}
        du(1) = dx;
        du(2) = dy;
        x = floor(dx);
        dx = dx-x;
        y = floor(dy);
        dy = dy-y;
        
        Int_Im_Intermediate = interp2(Im,1,lower(method))
        %upsample_size = 1/du;
        %Int = interp2(Im,upsample_size,lower(method))
%         
%         for yit = 1:Int_Im_y
%             for xit = 1:Int_Im_x
%                 
%                 Int_Im(yit,xit) = Int(xit*upsample_size,yit*upsample_size)
%                 
%                 %Vilket värde ska vi hämta ut när vi läser mellan...?
%             end
%         end
%         
end





end