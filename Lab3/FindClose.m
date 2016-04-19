function [A] = FindClose(colzt,rowzt,colzi,rowzi,boxSize)
%SUMMARY Creates a matrix A that keeps track of what points might be corresponding
% Rows in A represents intrest points in Imt
% Cols in A represent which intrest point in Imi is whithin boxSize from
% the intrest point we are currently trying to find closest to.

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

