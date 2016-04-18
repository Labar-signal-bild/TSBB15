function [A] = FindClose(It,Jt,Ii,Ji,boxSize)

n = length(It);
m = length(Ii);

A=zeros(n,m);

for i=1:n
    for j=1:m
        if(and(abs(It(i)-Ii(j))<boxSize,abs(Jt(i)-Ji(j))<boxSize))
            A(i,j)   = j;
        end
    end
end
end

