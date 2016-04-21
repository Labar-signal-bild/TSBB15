%% TSBB15 lab3
clear
clc
initcourse TSBB15
%%
close all
% Variables
supBox = 10; % Area for finding best harris point
regBox = 100; % Area for finding close intrest points
cutBox = 7; % Area round intrest point
threshold = 20000;
harrisPlot = 1;
fsz = 10;
std_g = 1;
%
%

Imt = imread('DCMI/img1.png');
Imi = imread('DCMI/img2.png');
Imt1 = rgb2gray(Imt);
%Imi1 = Imi(:,:,1);
Imi1 = rgb2gray(Imi);

 [Xt Xi corr_t, corr_i] = CorrPoints(Imt1,Imi1,supBox,regBox,cutBox,fsz,std_g,threshold,harrisPlot);
%show_corresp(Imt1,Imi1,Xt(1:2,:),Xi(1:2,:))
figure;colormap('gray');show_corresp(Imt1,Imi1,corr_t,corr_i)
%% 
N = 10000;
T = 1.5;
[F, Inliers_t, Inliers_i] = ransac(corr_t, corr_i, N, T);
Xt = corr_t;
Xi = corr_i;

%% Visualisation

% Are the results as expected?
% Where do the epipolar lines converge? Why?

% TODO: How does these functions work?
figure(3);clf;% imshow(Imi); hold on;
show_harris(Imi, Inliers_i(1,:),Inliers_i(2,:));
plot_eplines(F', Xt,[0 , size(Imi,1) , 0 , size(Imi,2)] ); 
hold off;
figure(4); clf;%imshow(Imt); hold on;
show_harris(Imt, Inliers_t(1,:),Inliers_t(2,:));
g = plot_eplines(F, Xi,[0 , size(Imt,1) , 0 , size(Imt,2)] );
%h = show_corresp(imageLeft, imageRight,P1,P2,cl);

%% Inlier ratio

% What value on the inlier threshold do you use?

in_ratio = 

%%




%% 5 LSQNONLIN and the GS algorithm

Fnew = gsalg(F,Xt,Xi);


%Ta bort outliers när vi försöker lösa !
%Använd inbyggda funktioner och låt lsqnonlin fixa ... något. F? X^?



