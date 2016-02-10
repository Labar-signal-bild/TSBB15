function [ V ] = LK_equation( I,J,grad_param) %perhaps parameters here
%LK_equation
%   Calculates vector field V to move a pixel from I to J
[fx fy lp] = LkGrad(J,grad_param);

V = zeros(size(I,1),size(I,2),2);
T11 = fx.^2;
T12 = fx.*fy;
T22 = fy.^2;
%This is the tensor for every point.


Is = conv2(lp,lp',I,'same');
Js = conv2(lp,lp',J,'same');

Z = [T11 T12 ; T12 T22];
e = [(Is-Js).*fx ; (Is-Js).*fy];
%This is the error for every point.
Vtemp = Z.\e;

for rowz=1:length(I(:,1))
    for colz=1:length(I(:,2))
        V(rowz,colz,1)=Vtemp(2*rowz-1,colz);
        V(rowz,colz,2)=Vtemp(2*rowz,colz);
    end
end

end
