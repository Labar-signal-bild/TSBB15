function [ V ] = LK_equation(I,J,gradParam,regSize) %perhaps parameters here
%LK_equation
disp('------ LK_equation ------')

V = zeros(size(I,1),size(I,2),2);

%Gaussian filter for aquiring Z
N = floor(regSize/2); 
sigma = gradParam(3); %sigma for convolution
lp=exp(-0.5*([-N:N]/sigma).^2);
lp=lp/sum(lp);

%   Calculates vector field V to move a pixel from I to J
[fx fy lpgrad] = LkGrad(J,gradParam);

%This is the tensor for every point.
T11 = fx.^2;
T12 = fx.*fy;
T22 = fy.^2;

%Calculate the tensor for a region around every point.
Z11 = conv2(lp,lp',T11,'same');
Z12 = conv2(lp,lp',T12,'same');
Z22 = conv2(lp,lp',T22,'same');

Is = conv2(lpgrad,lpgrad',I,'same');
Js = conv2(lpgrad,lpgrad',J,'same');

e1 = (Is-Js).*fx;
e2 = (Is-Js).*fy;

e1= conv2(lp,lp',e1,'same');
e2 = conv2(lp,lp',e2,'same');
%Calculate the tensor. Add small value to avoid singularities.
%epsilon = 0.00001;
%Z11 = Z11 + eye(size(Z11))*epsilon;
%Z12 = Z12 + eye(size(Z12))*epsilon;
%Z22 = Z22 + eye(size(Z22))*epsilon;
%calculating V = e\Z in another way
pdetZ = 1./(Z11.*Z22 - Z12.*Z12);
pdetZ(isinf(pdetZ)) = 0;
V(:,:,1) = pdetZ.*(Z22.*e1-Z12.*e2);
V(:,:,2) = pdetZ.*(-Z12.*e1+Z11.*e2);
end
