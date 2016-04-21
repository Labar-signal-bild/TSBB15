function p = IntrestPoints(Im,fsz,std_g,supBox,interest_thresh)

p   =   harris(Im,fsz,std_g);
p   =   non_max_suppression(p,supBox);
p   =   p>interest_thresh;
p   =   find(p==1);
end

