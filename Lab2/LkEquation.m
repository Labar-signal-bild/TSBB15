function [ V ] = LK_equation( I,J,gradParam,regSize) %perhaps parameters here
%LK_equation
disp('------ LK_equation ------\n')
N = floor(regSize/2);
NrowzMin = 0; NrowzMax = 0; NcolzMin = 0; NcolzMax = 0;
V = zeros(size(I,1),size(I,2),2);

%   Calculates vector field V to move a pixel from I to J
[fx fy lp] = LkGrad(J,gradParam);

%This is the tensor for every point.
T11 = fx.^2;
T12 = fx.*fy;
T22 = fy.^2;



%Need to calculate Z for everypoint by taking a small image region around
%every point.
rowzMin = 1; rowzMax = length(J(:,1)); colzMin = 1; colzMax = length(J(:,2));
Z11 = zeros(rowzMax,colzMax); Z12 = Z11; Z22 = Z11; e1 = Z11; e2 = Z11;

for rowz = 1:rowzMax
    for colz = rowzMin:rowzMax
        if rowz - N < rowzMin
            NrowzMin = rowzMin; 
        elseif rowz + N > rowzMax
            NrowzMax = rowzMax;
        end

        if colz - N < colzMin
            NcolzMin = colzMin; 
        elseif colz + N > colzMax
            NcolzMax = colzMax;
        end
        Z11(rowz,colz) = mean(mean(T11(NrowzMin:NrowzMax,NcolzMin:NcolzMax)));
        Z12(rowz,colz) = mean(mean(T12(NrowzMin:NrowzMax,NcolzMin:NcolzMax)));
        Z22(rowz,colz) = mean(mean(T22(NrowzMin:NrowzMax,NcolzMin:NcolzMax)));
        
        fxReg = fx(NrowzMin:NrowzMax,NcolzMin:NcolzMax);
        fyReg = fy(NrowzMin:NrowzMax,NcolzMin:NcolzMax);
        
        Ireg = I(NrowzMin:NrowzMax,NcolzMin:NcolzMax);
        Jreg = J(NrowzMin:NrowzMax,NcolzMin:NcolzMax);
        
        IregS = conv2(lp,lp',Ireg,'same');
        JregS = conv2(lp,lp',Jreg,'same');
        %This is the error for every point.
        e1(rowz,colz)=  mean(mean((IregS-JregS).*fxReg)); 
        e2(rowz,colz)=  mean(mean((IregS-JregS).*fyReg));
    end
end
2
%calculating V = e\Z in another way
pdetZ = 1./(Z11.*Z22 - Z12.*Z12);
pdetZ(find(pdetZ == inf)) = 0; % Setting pdet = 0 where detZ = 0
V(:,:,1) = pdetZ.*(Z22.*e1-Z12.*e2);
V(:,:,2) = pdetZ.*(-Z12.*e1+Z11.*e2);

end
