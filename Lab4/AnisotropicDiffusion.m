function [Lnew signalvar] = AnisotropicDiffusion(im,Lnew,k,it,delta_s)
%DIFFTENS diff_tensor = DiffTensor(L,k) Calculates the diffusion tensor
%k = stepsize for alpha
signalvar = zeros(1,it+1);
signalvar(1) =  sum(sum( (im-Lnew).^2)) ;

for i=1:it

    DHL_trace = zeros(size(Lnew));

    % Calculate structure tensor T with HarrisTensor
    [T11 T22 T12]= HarrisTensor(Lnew);

    % Hessian = approx acc to slide 64
    h11 = [0,0,0; 1,-2,1;0,0,0];
    h12 = 1/4*[1,0,-1; 0,0,0;-1,0,1];
    h22 = h11';
    H11 = conv2(Lnew,h11,'same');
    H12 = conv2(Lnew,h12,'same');
    H22 = conv2(Lnew,h22,'same');

    U = T11+T22;
    E = T11.*T22 - T12.*T12;

    %Perform EVD
    eigval = ones(size(Lnew,1),size(Lnew,2),2);
    sqrt_temp = sqrt(U.^2/4-E);
    eigval(:,:,1) = U/2 + sqrt_temp;
    eigval(:,:,2) = U/2 - sqrt_temp;

    eigvec = ones(size(Lnew,1),size(Lnew,2),4);
    eigvec(:,:,1) = eigval(:,:,1) - T22 ;
    eigvec(:,:,2) = T12;
    eigvec(:,:,3) = eigval(:,:,2) - T22 ;
    eigvec(:,:,4) = T12;

    absEigVec1 = sqrt(eigvec(:,:,1).^2+eigvec(:,:,2).^2);
    absEigVec2 = sqrt(eigvec(:,:,3).^2+eigvec(:,:,4).^2);
    
    eigvec(:,:,1) = eigvec(:,:,1)./absEigVec1;
    eigvec(:,:,2) = eigvec(:,:,2)./absEigVec1;
    eigvec(:,:,3) = eigvec(:,:,3)./absEigVec2;
    eigvec(:,:,4) = eigvec(:,:,4)./absEigVec2;
    
    % Calculate alpha from lambda.
    alpha = ones(size(Lnew,1),size(Lnew,2),2);
    alpha(:,:,1) = exp(-eigval(:,:,1) ./ k);
    alpha(:,:,2) = exp(-eigval(:,:,2) ./ k);

    % Calculate D acc to p 56

    D = ones(size(Lnew,1),size(Lnew,2),4);
    D(:,:,1) = alpha(:,:,1) .* eigvec(:,:,1).^2 + alpha(:,:,2) .* eigvec(:,:,3).^2;
    D(:,:,2) = alpha(:,:,1) .* eigvec(:,:,1) .* eigvec(:,:,2) + ...
                alpha(:,:,2) .* eigvec(:,:,3) .* eigvec(:,:,4);
    D(:,:,3) = D(:,:,2);
    D(:,:,4) = alpha(:,:,1) .* eigvec(:,:,2).^2 + alpha(:,:,2) .* eigvec(:,:,4).^2;

    DHL_trace = D(:,:,1) .* H11 + D(:,:,2) .* H12 + D(:,:,3) .* H12 + D(:,:,4) .* H22;

    Lnew = Lnew + delta_s * DHL_trace;
    signalvar(i+1) = sum(sum( (im-Lnew).^2));%var(Lnew(:));
end
end

