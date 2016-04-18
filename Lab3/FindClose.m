function [A] = FindClose(colzt,rowzt,colzi,rowzi,boxSize)
%SUMMARY Creates a matrix A that keeps track of what points might be
%corresponding
size_t = length(rowzt);
size_i = length(rowzi);

A=zeros(size_t,size_i);

for i=1:size_t
    for j=1:size_i
        if(and(abs(rowzt(i)-rowzi(j))<boxSize,abs(colzt(i)-colzi(j))<boxSize))
            A(i,j)   = j;
        end
    end
end
end

