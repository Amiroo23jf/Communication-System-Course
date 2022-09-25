function [out] = PulseShaping(in, pulse0, pulse1)
pulse0 = str2num(pulse0);
pulse1 = str2num(pulse1);
out = zeros(1, length(in)*length(pulse0));
len = length(pulse0);
for i=1:length(in)
    if in(i)==0
        out(len*(i-1) + 1:len*i) = pulse0;
    else
        out(len*(i-1) + 1:len*i) = pulse1;
    end
end

