function [ dtot,e,Z ] = LkTracker( Im1,Im2, intrest_point)
%LKTRACKER Main function for LKTracker
dtot = zeros(size(intrest_point));

reg_size_x = 70/2;
reg_size_y = 40/2;
filter_size = 8;
std_grad = 1/2;

grad_param = [filter_size;std_grad];

for j = 1:length(intrest_point)
Im1_reg = Im1(intrest_point(j,1)-reg_size_x:intrest_point(j,1)+reg_size_x-1,...
             intrest_point(j,2)-reg_size_y:intrest_point(j,2)+reg_size_y-1);

         for i =1:50 
             
             Im2_reg = Im2(intrest_point(j,1)-reg_size_x:intrest_point(j,1)+reg_size_x-1,...
                 intrest_point(j,2)-reg_size_y:intrest_point(j,2)+reg_size_y-1);
             
             Z = LkTensor(Im2_reg,grad_param);
             e = LkDiff(Im1_reg,Im2_reg,grad_param);
             d = Z\e;
             Im2 = LkInterpol(Im2,d,'move');
             dtot(j,:) = dtot(j,:)+d'
         end
end

end

