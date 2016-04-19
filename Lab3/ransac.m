function [ Fopt , Inliers_t, Inliers_i ] = ransac(Xt, Xi, N, T)



num_inliers_old = 0;
Xl = zeros(2,8);
Xr = zeros(2,8);

for n = 1:N
    num_inliers = 0;
    Inliers_t_temp = [];
    Inliers_i_temp = [];
    % (iiia) This works only if Xt and Xi are sorted so that Xt1 correspond
    % to Xi1 and so on...
    
    random = sort(randsample(length(Xt),8)); % Changed to 8 
    for r = 1:8
        Xl(:, r) = Xt(:,random(r));
        Xr(:, r) = Xi(:,random(r));
    end
        
    
    F = fmatrix_stls(Xl,Xr);
    % (iiib)
    distance = fmatrix_residuals(F, Xt, Xi);
    
    % (iiic)
    for k = 1:length(distance) 
        if sqrt((distance(1,k)^2 + distance(2,k)^2)) < T % Inlier treshold
            num_inliers = num_inliers + 1;
   
            Inliers_t_temp = [Inliers_t_temp, Xt(:,k)];
            Inliers_i_temp = [Inliers_i_temp, Xi(:,k)];
            
        end
    end
    
    % Choose F with largest amount of inliers
    if num_inliers > num_inliers_old
        Fopt = F;
        num_inliers_old = num_inliers;
        Inliers_t = Inliers_t_temp;
        Inliers_i = Inliers_i_temp;
    end
    
    
end

inlier_ratio = num_inliers_old/length(distance) 

end

