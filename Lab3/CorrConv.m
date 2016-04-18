function [Xi Xt] = CorrConv(A,rt,ri,It,Jt,Ii,Ji,thresh)
Xt = [];
Xi = [];
[I J] = size(A);

for i=1:I
    best_match = 0;
    best_value = inf;
    
    pos = find(A(i,:)>0);
    Rt = reshape(rt(:,i),7,7);
    
    for j=pos
        best_match=j;
        %Ri = reshape(ri(:,j),7,7);
        %simularity = abs(sum(sum(Rt-Ri))); % M�ste ha b�ttre funktion f�r att plocka ut korresponderande punkter
        %if(and(best_value > simularity,thresh > simularity))
        %    best_match = j;
        %end
    end
    
    if(best_match > 0)
        Xt_new = [Jt(i) It(i)  1]';
        Xt     = [Xt Xt_new];
        
        Xi_new = [Ji(best_match) Ii(best_match) 1]';
        Xi     = [Xi Xi_new];
    end
end
end

