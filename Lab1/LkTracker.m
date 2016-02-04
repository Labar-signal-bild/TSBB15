function [ dtot ] = LkTracker( Im1,Im2,d )
%LKTRACKER Main function for LKTracker
dtot = d;
Z = LkTensor(Im2)
e = LkDiff(Im2,Im1)
d = e\Z
end

