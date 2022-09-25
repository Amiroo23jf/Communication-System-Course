function [out1, out2] = Divide(in)
%DIVIDE Divides the signal into two signals with half of the size of the
%initial signal
len = length(in);
ind = 1:len/2;
out1 = in(ind*2);
out2 = in(ind*2 - 1);
end

