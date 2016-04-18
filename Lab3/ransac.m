function [ Fopt ] = ransac(Xt, Xi, N, T)


num_inliers = 0;
num_inliers_old = 0;
Xl = zeros(2,8);
Xr = zeros(2,8);

for n = 1:N
    % (iiia) This works only if Xt and Xi are sorted so that Xt1 correspond
    % to Xi1 and so on...
    
    random = sort(randsample(length(Xt),8)); % Changed to 8 
    for r = 1:8
        Xl(:, r) = Xt(:,random(r));
        Xr(:, r) = Xi(:,random(r));
    end
        
    
    F = fmatrix_stls(Xl,Xr);
    % (iiib)
    distance = fmatrix_residuals(F, Xl, Xr);
    % (iiic)
    for k = 1:length(distance) 
        if (distance(1,k)^2 + distance(2,k)^2) < T % Inlier treshold
            num_inliers = num_inliers + 1;
        end
    end
    
    % Choose F with largest amount of inliers
    if num_inliers > num_inliers_old
        Fopt = F;
        num_inliers_old = num_inliers;
    end
    
    
end

end

