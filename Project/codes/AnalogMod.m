function [xc] = AnalogMod(x1, x2, fs, fc)
t = 0:1/fs:(length(x1)-1)/fs;
xc = x1 .* cos(2*pi*fc*t) + x2 .* sin(2*pi*fc*t);
end

