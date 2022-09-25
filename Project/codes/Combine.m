function [out] = Combine(in1, in2)
%COMBINE is the reverse system of Divide.
ind = 1:length(in1);
out = zeros(1, length(in1)*2);
out(ind*2) = in1;
out(ind*2-1) = in2;
end

