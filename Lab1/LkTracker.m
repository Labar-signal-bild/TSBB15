function [ dtot,e,Z ] = LkTracker( Im1,Im2, interest_point)
%LKTRACKER Main function for LKTracker
dtot = zeros(size(interest_point));

reg_size_x = 30/2;
reg_size_y = 30/2;
filter_size = 8;
std_grad = 2;

grad_param = [filter_size;std_grad];
Im2save = Im2;

for j = 1:length(interest_point)
Im1_reg = Im1(interest_point(j,1)-reg_size_x:interest_point(j,1)+reg_size_x,...
             interest_point(j,2)-reg_size_y:interest_point(j,2)+reg_size_y);

4
         for i =1:10
             
             Im2_reg = Im2(interest_point(j,1)-reg_size_x:interest_point(j,1)+reg_size_x,...
                 interest_point(j,2)-reg_size_y:interest_point(j,2)+reg_size_y);
             
             Z = LkTensor(Im2_reg,grad_param);
             e = LkDiff(Im1_reg,Im2_reg,grad_param);
             d = Z\e;
             Im2 = LkInterpol(Im2,d,'move');
             dtot(j,:) = dtot(j,:)+d';
         end
         Im2 = Im2save;
end

end

