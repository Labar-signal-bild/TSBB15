function [Xi Xt] = CorrConv(A,rt,ri,colzt,rowzt,colzi,rowzi,thresh)
%Summary finds which intrest point in Imi which best matches the intensity
%value of intrest point k in Imt

Xt = [];
Xi = [];
[rowz colz] = size(A);

for i=1:rowz
    best_match = 0;
    best_value = inf;
    
    pos = find(A(i,:)>0);
    meanRt = mean(rt(:,i));
    
    for j=pos
        best_match=j;
        meanRi=mean(ri(:,j));
        error = abs(meanRt-meanRi);
        if(and(best_value > error,thresh > error))
            best_match = j;
        end
    end
    
    if(best_match > 0)
        Xt_new = [colzt(i) rowzt(i)  1]';
        Xt     = [Xt Xt_new];
        
        Xi_new = [Ji(best_match) rowzi(best_match) 1]';
        Xi     = [Xi Xi_new];
    end
end
end

