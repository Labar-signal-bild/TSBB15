function h=show_harris(Im, colz,rowz)

hold off;
imshow(Im);axis image
hold on
for k=1:length(rowz),
  h(k)=plot(colz(k),rowz(k),'ro');
end

h=0;
end