function snr = RestorationPlot(im1,im2,im3,im4,noise_var,epochs,IMAGE_SET)
im1_mean = mean(mean(im1));
im2_mean = mean(mean(im2));
im3_mean = mean(mean(im3));
im4_mean = mean(mean(im4));

colorAxis = [min(im1(:))-.1 max(im1(:))+.1];

if(~(IMAGE_SET == 3))
    title1 = ['Original image ' num2str(im1_mean)];
    title2 = ['With noise, mean = ' num2str(im2_mean)];
    title3 = ['Enhancement, mean = ' num2str(im3_mean)];
    title4 = ['Difference after ' num2str(epochs) ' epochs'];
    
    signal_var =  var(im3(:));
    snr = 10 * log10(signal_var / noise_var);
else
    title1 = ['With out noise ' num2str(im1_mean)];
    title2 = ['With low noise, mean = ' num2str(im2_mean)];
    title3 = ['With medium noise, mean = ' num2str(im3_mean)];
    title4 = ['With high noise, mean = ' num2str(im4_mean)]; 
    
    snr = 0;
end

%imshow(im,[0 1]) if we have a binary image with many epochs
figure
    subplot(2,2,1);
        imagesc(im1, colorAxis); colorbar;;title(title1);
    subplot(2,2,2);
        imagesc(im2, colorAxis); colorbar;;title(title2);
    subplot(2,2,3);
        imagesc(im3, colorAxis); colorbar;;title(title3);
    subplot(2,2,4);
        imagesc(im4, colorAxis); colorbar;;title(title4);
end

