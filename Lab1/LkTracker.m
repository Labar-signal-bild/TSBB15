function [ dtot,e,Z ] = LkTracker( Im1,Im2,d, intrest_point)
%LKTRACKER Main function for LKTracker
dtot = d;
d = 1000;
reg_size_x = 70/2;
reg_size_y = 40/2;
filter_size = 8;
std_grad = 2;

grad_param = [filter_size;std_grad];

% Ta ut en intresant region
Im1_reg = Im1(intrest_point(1)-reg_size_x:intrest_point(1)+reg_size_x-1,...
             intrest_point(2)-reg_size_y:intrest_point(2)+reg_size_y-1);

%Bra startvärde??
for i =1:50 %while sum(abs(d)) > 0.1
    
    Im2_reg = Im2(intrest_point(1)-reg_size_x:intrest_point(1)+reg_size_x-1,...
             intrest_point(2)-reg_size_y:intrest_point(2)+reg_size_y-1);

    Z = LkTensor(Im2_reg,grad_param)
    e = LkDiff(Im1_reg,Im2_reg,grad_param)
    d = Z\e
    Im2 = LkInterpol(Im2,d,'move');
    dtot = dtot+d
end


end

