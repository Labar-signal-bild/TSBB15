%function h=show_corresp(imageLeft, imageRight,P1,P2,cl)
%
% Visualise a list of correspondences by
% drawing a line between the points in
% image1 and in image2.
%
% imageLeft:    Left image
% imageRight:   Right image
% P1:    List of points in image1 in a 2xN matrix.
% p1:    List of points in image2 in a 2xN matrix.
% cl:    Correspondence list in a 2xN matrix
% 
%
% i.e. points P1(cl(k,1),:) and P2(cl(k,2),:)
% correspond.
%
%Per-Erik Forssen, Nov 2004, johan hedborg, 2013, Marcus Wallenberg, 2014

function h=show_harris(Im, X, Y)

hold off;
imshow(Im);axis image
hold on
for k=1:length(X),
  h(k)=plot(Y(k),X(k),'ro');
end

h=0;
end