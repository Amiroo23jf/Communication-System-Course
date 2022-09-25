function [out] = Channel(in, fs, fchannel, bw)
out = bandpass(in, [fchannel-bw/2 fchannel+bw/2], fs);
end

