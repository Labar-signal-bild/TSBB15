function [] = imagebw(im,type)

if type == 0
    imagesc(im,[0 255]); 
else
    
    imagesc(im);
    
end

 colormap(gray)
end

