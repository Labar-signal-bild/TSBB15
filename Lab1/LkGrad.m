function [ fx fy] = LkGrad(Im,N,sigma)
%LKGRAD Estimate the regularizeed gradient for an image

lp=exp(-0.5*([-N:N]/sigma).^2);
lp=lp/sum(lp);
df=-1/sigma^2*[-N:N].*lp;
fx=conv2(lp,df',Im,'same');
fy=conv2(df,lp',Im,'same');

end

