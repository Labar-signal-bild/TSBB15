function [Xi Xt indt indi] = MeanIntensity(A,rt,ri,Ipt,Ipi,error_thresh, cutBox)
%Summary finds which intrest point in Imi which best matches the intensity
%value of intrest point k in Imt

Xt = [];
Xi = [];
indt = [];
indi = [];
length_Ipt = length(Ipt)
length_Ipi = length(Ipi)
intrest_matrix = inf * ones(length_Ipt,length_Ipi);


for currentRow=1:length_Ipt
    %pos = find(A(colz,:)>0);
    
    Rt = rt(:,currentRow);
    
    %Rt = reshape(rt(:,currentRow),cutBox, cutBox);
    
    %for currentCol=pos
    for currentCol=1:length_Ipi
        
        Ri=ri(:,currentCol);
        %Ri= reshape(ri(:,currentCol), cutBox, cutBox);
        error = sum(sum((Rt-Ri).^2));
        %error2 = sum(sum(norm(xcorr2(Rt, Ri))));
        
        intrest_matrix(currentRow,currentCol) = error;
        
    end
end
 
%intrest_matrix

%[value row col] = joint_min(intrest_matrix);
%{
for i=1:length(value)
    Xt_new = [Ipt(1,row(i)) Ipt(2,row(i))  1]';
    Xt     = [Xt Xt_new];

    Xi_new = [Ipi(1,col(i)) Ipi(2,col(i))  1]';
    Xi     = [Xi Xi_new];
end
%}

[value,indthelp,indihelp] = joint_min(intrest_matrix);

for it = 1:length(value)
    if value(it) < error_thresh
        indt = [indt, indthelp(it)];
        indi = [indi, indihelp(it)];
    end
end
            
%{
while min(min(intrest_matrix)) < error_thresh
    
    [row, col] = find(intrest_matrix == min(min(intrest_matrix)));
    
    %If many in t and i, just take first one.
    Xt_new = [Ipt(1,row(1)) Ipt(2,row(1))  1]';
    Xt     = [Xt Xt_new];

    Xi_new = [Ipi(1,col(1)) Ipi(2,col(1))  1]';
    Xi     = [Xi Xi_new];
    
    min(min(intrest_matrix));
   intrest_matrix(row(1),:) = inf;
   intrest_matrix(:,col(1)) = inf;
   
end
%}


end

