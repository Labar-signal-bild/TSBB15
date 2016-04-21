function [indt indi] = MeanIntensity(rt,ri,Ipt,Ipi,error_thresh)
%Summary finds which intrest point in Imi which best matches the intensity
%value of intrest point k in Imt

indt = [];
indi = [];
length_Ipt = length(Ipt);
length_Ipi = length(Ipi);
intrest_matrix = inf * ones(length_Ipt,length_Ipi);


for currentRow=1:length_Ipt
    
    Rt = rt(:,currentRow);
    
    for currentCol=1:length_Ipi
       
        Ri=ri(:,currentCol);
        error = sum(sum((Rt-Ri).^2));        
        
        intrest_matrix(currentRow,currentCol) = error;
    end
end
 
[value,indthelp,indihelp] = joint_min(intrest_matrix);

for it = 1:length(value)
    if value(it) < error_thresh
        indt = [indt, indthelp(it)];
        indi = [indi, indihelp(it)];
    end
end

end

