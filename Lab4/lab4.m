%% TSBB15 lab4
clear
clc
initcourse TSBB15
close all
%% Algorithm overview
im = double(imread('cameraman.tif'));
k = 1;
iterations = 1000;

% Calculate structure tensor T with HarrisTensor
[T11 T22 T12]= HarrisTensor(im);
%TODO FIX MATRIX OF STRUCTS !
eigstructmat = (size(im));
for i = 1:size(im,1)
    for j = 1:size(im,2)
    
        T = [T11(i,j) , T12(i,j) ;...
             T12(i,j) ,T22(i,j) ];
        
        % EVD T and extract eigienvalues lambda
        [eigvec,eigval] = eig(T);
    
        eigstructmat(i,j) = struct('eigvec',eigvec,'eigval',eigval)
    end
end

alpha = exp(-eigval/k)

% Calculate alpha from lambda.
% Calculate D acc to p 58
% L = image
% Hessian = approx acc to slide 64
% Calu
%make blur fn