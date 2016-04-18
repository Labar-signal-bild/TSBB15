function [Xi Xt] = CorrConv(A,rt,ri,rowzt,colzt,rowzi,colzi,thresh)
Xt = [];
Xi = [];
[rowz colz] = size(A);

for i=1:rowz
    best_match = 0;
    best_value = inf;
    
    pos = find(A(i,:)>0);
    Rt = reshape(rt(:,i),7,7);
    
    for j=pos
        best_match=j;
        %Ri = reshape(ri(:,j),7,7);
        %simularity = abs(sum(sum(Rt-Ri))); % Måste ha bättre funktion för att plocka ut korresponderande punkter
        %if(and(best_value > simularity,thresh > simularity))
        %    best_match = j;
        %end
    end
    
    if(best_match > 0)
        Xt_new = [colzt(i) rowzt(i)  1]';
        Xt     = [Xt Xt_new];
        
        Xi_new = [Ji(best_match) rowzi(best_match) 1]';
        Xi     = [Xi Xi_new];
    end
end
end

