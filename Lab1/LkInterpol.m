function [ Int_Im ] = LkInterpol(Im,du,type)
%LKINTERPOL Returns value from interpolation interval
% du contains [dx ,dy]

switch lower(type)
    case{'upsample'}
       
        %We always want to upsample with 2.
        Int_Im = interp2(Im,1)
        
    case{'move'}
        dx = du(1);
        dy = du(2);     
        Y = [1:size(Im,1)]';
        X = [1:size(Im,2)];
        Yq = Y + dy;
        Xq = X + dx;
       
        Int_Im = interp2(X,Y,Im,Xq,Yq);
        Int_Im(isnan(Int_Im)) = 0;
end





end