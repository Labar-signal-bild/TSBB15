%% TSBB15 lab3
clear
clc
initcourse TSBB15
close all
mex non_max_suppression.c
%%
% Variables
supBox = 10; % Area for finding best harris point
regBox = 100; % Area for finding close intrest points
cutBox = 7; % Area round intrest point
threshold = 6200; %Adjusts amount of Harris points
interest_thresh = 500; %Decrease to increase amount of Harris points
harrisPlot = 1;
fsz = 10;
std_g = 1;


Imt = imread('DCMI/img1.png');
Imi = imread('DCMI/img2.png');
Imt1 = rgb2gray(Imt);
Imi1 = rgb2gray(Imi);

[Xt, Xi] = CorrPoints(Imt1,Imi1,supBox,cutBox,fsz,std_g,threshold,interest_thresh,harrisPlot);
figure;colormap('gray');show_corresp(Imt1,Imi1,Xt,Xi)
%% 
N = 10000;
T = 2; %Increase to make more inliers
[F, Inliers_t, Inliers_i] = ransac(Xt, Xi, N, T);

%% Visualisation


figure(3);clf;
show_harris(Imi, Inliers_i(1,:),Inliers_i(2,:));
plot_eplines(F', Xt,[0 , size(Imi,1) , 0 , size(Imi,2)] ); 
hold off;
figure(4); clf;
show_harris(Imt, Inliers_t(1,:),Inliers_t(2,:));
g = plot_eplines(F, Xi,[0 , size(Imt,1) , 0 , size(Imt,2)] );

%% 5 LSQNONLIN and the GS algorithm

%Calculate cameras for GS
[Ct Ci] = fmatrix_cameras(F);

%Triangulate 3D points and remove homog. Correct camera order...?
tri_opt = [];

for it = 1:length(Inliers_t)
    new_point = triangulate_optimal(Ct,Ci,Inliers_t(:,it),Inliers_i(:,it));
    new_point = new_point(1:3)/new_point(4);
    tri_opt = [ tri_opt new_point ];
end

vars = [ Ct(:) ; tri_opt(:)];

vars_new = lsqnonlin(@(vars) fmatrix_residuals_gs(vars,Inliers_t,Inliers_i),vars)

Ctnew = reshape(vars_new(1:12),3,4)
Fnew = fmatrix_from_cameras(Ctnew,Ci)

% Get new inliers from new F
distance = fmatrix_residuals(Fnew, Xt, Xi);

Inliers_tgs = [];
Inliers_igs = [];
for k = 1:length(distance) 
    if sqrt((distance(1,k)^2 + distance(2,k)^2)) < T % Inlier treshold
        Inliers_tgs= [Inliers_tgs, Xt(:,k)];
        Inliers_igs= [Inliers_igs, Xi(:,k)];
    end
end

%% Visualisation
figure(5);clf;
show_harris(Imi, Inliers_igs(1,:),Inliers_igs(2,:));
plot_eplines(Fnew',Xt,[0 , size(Imi,1) , 0 , size(Imi,2)] ); 
hold off;
figure(6); clf;
show_harris(Imt, Inliers_tgs(1,:),Inliers_tgs(2,:));
g = plot_eplines(Fnew, Xi,[0 , size(Imt,1) , 0 , size(Imt,2)] );

%% Verification
err_old = gsfun(F,Inliers_t,Inliers_i);
err_new = gsfun(Fnew,Inliers_tgs,Inliers_igs);
err_old_mean = abs(mean(err_old,2))
err_new_mean = abs(mean(err_new,2))
new_err_perc_of_old = err_new_mean ./ err_old_mean*100
