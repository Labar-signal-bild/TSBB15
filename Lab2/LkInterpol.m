function [ Int_Im ] = LkInterpol(Im,V,type)
%LKINTERPOL Returns value from interpolation interval

switch lower(type)
    case{'upsample'}
       
        %We always want to upsample with 2.
        Int_Im = 2*interp2(Im,1);
        
    case{'move'}
        dx = V(:,:,1); % Displacement in x
        dy = V(:,:,2); % Displacement in y
        X = [1:size(Im,1)];
        Y = [1:size(Im,2)];
        Xgrid = meshgrid(Y,X);
        Ygrid = meshgrid(X,Y)';
        
        Yq = Ygrid + dy;
        Xq = Xgrid + dx;
       
        Int_Im = interp2(Xgrid,Ygrid,Im,Xq,Yq);
        Int_Im(isnan(Int_Im)) = 0;
end

end