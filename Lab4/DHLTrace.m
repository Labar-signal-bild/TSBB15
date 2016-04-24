function DHL_trace = DHLTrace(L,k)
%DIFFTENS diff_tensor = DiffTensor(L,k) Calculates the diffusion tensor
%k = stepsize for alpha

DHL_trace = zeros(size(L));

% Calculate structure tensor T with HarrisTensor
[T11 T22 T12]= HarrisTensor(L);

% Hessian = approx acc to slide 64
h11 = [0,0,0; 1,-2,1;0,0,0];
h12 = 1/4*[1,0,-1; 0,0,0;-1,0,1];
h22 = h11';
H11 = conv2(L,h11,'same');
H12 = conv2(L,h12,'same');
H22 = conv2(L,h22,'same');
   
for i = 1:size(L,1)
    for j = 1:size(L,2)

    T = [T11(i,j) , T12(i,j)  ; ...
         T12(i,j) , T22(i,j) ];
    HL = [H11(i,j) , H12(i,j)  ; ...
        H12(i,j) , H22(i,j) ];

    % EVD T and extract eigenvalues lambda
    [eigvec,eigval] = eig(T);

    % Calculate alpha from lambda.
    alpha = exp(-diag(eigval)/k);

    % Calculate D acc to p 56
    D = alpha(1) * eigvec(:,1) * eigvec(:,1)' +...
        alpha(2) * eigvec(:,2) * eigvec(:,2)';

    DHL_trace(i,j) = trace(D*HL);
    end
end

end

