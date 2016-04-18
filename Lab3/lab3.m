%% TSBB15 lab3
clear
clc
initcourse TSBB15

%% 
N = 15;
T = 1;
F = ransac(Xt, Xi, N, T);

%% Visualisation

% Are the results as expected?
% Where do the epipolar lines converge? Why?

% TODO: How does these functions work?
h = plot_eplines(F, Xt, [yl yh xl xh]); % TODO: Define imbox
h = show_corresp(imageLeft, imageRight,P1,P2,cl);

%% Inlier ratio

%What value on the inlier threshold do you use?

%TODO

%%




%% 5 LSQNONLIN and the GS algorithm







