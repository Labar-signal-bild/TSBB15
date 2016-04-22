%% TSBB15 lab4
cd ~/Documents/TSBB15/Lab4
clear
clc
initcourse TSBB15
close all
%% Algorithm overview
L = double(imread('cameraman.tif'));
k = 1;
delta_s = 1;
iterations = 1000;

% Calculate structure tensor T with HarrisTensor
[T11 T22 T12]= HarrisTensor(L);


% Hessian = approx acc to slide 64
h11 = [0,0,0; 1,-2,1;0,0,0];
h12 = 1/4*[1,0,-1; 0,0,0;-1,0,1];
h22 = h11';
H11 = conv2(L,h11,'same');
H12 = conv2(L,h12,'same');
H22 = conv2(L,h22,'same');

eiginit = zeros(2);
eigstruct = repmat(struct('alpha',[0 0],'diff_tens',eiginit),size(L));
for i = 1:size(L,1)
    for j = 1:size(L,2)
    
        T = [T11(i,j) , T12(i,j)  ; ...
             T12(i,j) , T22(i,j) ];
        HL = [H11(i,j) , H12(i,j)  ; ...
              H12(i,j) , H22(i,j) ];
         
        % EVD T and extract eigienvalues lambda
        [eigvec,eigval] = eig(T);
        
        % Calculate alpha from lambda.
        alpha = exp(-diag(eigval)/k);
        
        % Calculate D acc to p 56
        D = alpha(1) * eigvec(:,1) * eigvec(:,1)' +...
            alpha(2) * eigvec(:,2) * eigvec(:,2)';
        delta_s * trace(D*HL);
         
        eigstruct(i,j) = struct('alpha',alpha,'diff_tens',D);
    end
end



% L = image
%TODO: 
% - Make blur fn to blur image
% - What is s? What is delta s?
