function [ fx fy lp] = LkGrad(Im,N,sigma)
%LKGRAD Estimate the regularizeed gradient for an image
if sigma == 0
    sigma = 0.1;
    disp('----- 0 std into LkGrad -----');
end
lp=exp(-0.5*([-N:N]/sigma).^2);
lp=lp/sum(lp);
df=-1/sigma^2*[-N:N].*lp;
%df=df/sum(df);
fx=conv2(lp,df',Im,'same');
fy=conv2(df,lp',Im,'same');

end

